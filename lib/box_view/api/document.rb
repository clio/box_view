module BoxView
  module Api
    class Document < Base

      include BoxView::Api::Actions::Findable
      include BoxView::Api::Actions::Listable
      include BoxView::Api::Actions::Crudable

      def self.supported_filetypes
        [:pdf, :doc, :docx, :ppt, :pptx]
      end

      def self.supported_filetype?(filetype)
        supported_filetypes.include?(filetype)
      end

      def create(*args)
        raise NotImplementedError
      end

      def upload(url, name)
        data_item(session.post(endpoint_url, { url: url, name: name }.to_json), session)
      end

      def thumbnail(id, width, height)
        session.get("#{endpoint_url}/#{id}/thumbnail", { width: width, height: height }, false)
      end

      def content(id, extension=nil)
        supported_extensions = %w(zip pdf)
        raise ArgumentError.new("Unsupported content extension #{extension}. Must use one of #{supported_extensions} or nil.") unless supported_extensions.include?(extension) || extension.nil?

        extension = ".#{extension}" if extension
        session.get("#{endpoint_url}/#{id}/content#{extension}", {}, false)
      end

      private

      def data_klass
        BoxView::Models::Document
      end

      def endpoint_url; "documents"; end

    end
  end
end