module BoxView
  module Http
    def base_uri(path, params = {})
      uri = URI.parse("https://view-api.box.com")
      uri.path = path
      uri.query = URI.encode_www_form(params) if params.any?
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
      parse_response(res, parse)
    end

    def parse_response(res, parse=true)
      parse ? JSON.parse(res.body) : res.body
    end

    private

    def api_prefix()
      "/1"
    end

  end
end
