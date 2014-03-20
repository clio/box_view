module BoxView
  module Http

    require 'time'

    class Error < BoxView::Error; end

    class BadRequestError < BoxView::Http::Error; end
    class RetryNeededError < BoxView::Http::Error
      attr_reader :retry_after

      def initialize(msg, retry_after)
        @retry_after = retry_after
        super(msg)
      end
    end

    def base_uri(path, params = {})
      uri = URI.parse("https://view-api.box.com")
      uri.path = path
      uri.query = URI.encode_www_form(convert_params(params)) if params.any?
      uri
    end

    def get(path, params={}, parse=true)
      uri = base_uri("#{api_prefix}/#{path}", params)
      req = Net::HTTP::Get.new(uri.to_s)
      make_api_request(req, uri, parse)
    end


    def post(path, body="", parse=true)
      uri = base_uri("#{api_prefix}/#{path}")
      req = Net::HTTP::Post.new(uri.request_uri)
      req.body = body
      req.add_field("Content-Type", "application/json")
      make_api_request(req, uri, parse)
    end

    def put(path, body="", parse=true)
      uri = base_uri("#{api_prefix}/#{path}")
      req = Net::HTTP::Put.new(uri.request_uri)
      req.body = body
      req.add_field("Content-Type", "application/json")
      make_api_request(req, uri, parse)
    end

    def delete(path, parse=true)
      uri = base_uri("#{api_prefix}/#{path}")
      req = Net::HTTP::Delete.new(uri.request_uri)
      make_api_request(req, uri, parse)
    end

    def make_api_request(req, uri, parse=true)
      return if self.token.nil? || self.token.empty?
      req.add_field("Authorization", "Token #{self.token}")
      make_request(req, uri, parse)
    end

    def make_request(req, uri, parse=true)
      req.add_field("Accept", "text/json")
      n = Net::HTTP.new(uri.host, uri.port)
      n.use_ssl = true
      res = n.start do |http|
        http.request(req)
      end
      check_for_error(res)
      parse ? parse_response(res) : res.body
    end

    def check_for_error(res)
      case res
      when Net::HTTPAccepted
        if res['Retry-After']
          raise BoxView::Http::RetryNeededError.new('Retry Needed', res['Retry-After'])
        end
      when Net::HTTPBadRequest
        msg = 'Bad Request'
        if err_dets = error_details(res)
          msg += " (#{err_dets})"
        end

        raise BoxView::Http::BadRequestError.new(msg)
      end
    end

    def parse_response(res)
      JSON.parse(res.body)
    rescue JSON::ParserError
      nil
    end

    def convert_params(params)
      params.each_pair do |key, val|
        if [Date, Time, DateTime].include?(val.class)
          params[key] = val.iso8601
        end
      end
      params
    end

    private

    def error_details(res)
      if resp_json = parse_response(res)
        if details = resp_json['details']
          details.map { |d| [d['field'], d['message']].join(': ') }.join(' ')
        end
      end
    rescue
      nil
    end

    def api_prefix()
      "/1"
    end

  end
end
