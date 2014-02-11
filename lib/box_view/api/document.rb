module BoxView
  module Api
    class Document < Base

      include BoxView::Api::Actions::Findable
      include BoxView::Api::Actions::Listable
      include BoxView::Api::Actions::Crudable

      def item_from_data(response_data, action)
        if action == :list
          response_data["document_collection"]["entries"]
        else
          response_data
        end
      end

      def create(*args)
        raise NotImplementedError
      end

      def upload(url)
        data_item(session.post(endpoint_url, { url: url }.to_json), session)
      end

      def thumbnail(id, width, height, filename)
        f = File.open(filename, 'w')
        f.write(session.get("documents/#{id}/thumbnail", { width: width, height: height }, false))
        f.flush
        f.close
        f
      end

      def content(id, filename)
        raise ArgumentError.new("filename cannot be blank") if filename.nil? || filename.empty?

        extension = filename.split(".").last
        supported_extensions = %w(zip pdf)
        raise ArgumentError.new("Unsupported content extension #{extension}. Must use one of #{supported_extensions}.") unless supported_extensions.include?(extension)

        f = File.open(filename, 'w')
        f.write(session.get("documents/#{id}/content.#{extension}", {}, false))
        f.flush
        f.close
        f
      end

      private

      def data_klass
        BoxView::Models::Document
      end

      def endpoint_url; "documents"; end

    end
  end
end