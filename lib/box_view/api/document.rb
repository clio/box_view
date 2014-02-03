module BoxView
  module Api
    class Document < Base

      def upload(url)
        session.post("documents", { url: url }.to_json)
      end

    end
  end
end