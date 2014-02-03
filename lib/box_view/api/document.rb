module BoxView
  module Api
    class Document < Base

      def list
        session.get("documents")["document_collection"]["entries"].collect{ |doc| data_item(doc, session) }
      end

      def find(id)
        data_item(session.get("documents/#{id}"), session)
      end

      def upload(url)
        data_item(session.post("documents", { url: url }.to_json), session)
      end

      def thumbnail(id, width, height, filename)
        f = File.open(filename, 'w')
        f.write(session.get("documents/#{id}/thumbnail", { width: width, height: height }, false))
        f.flush
        f.close
        f
      end

      def data_klass
        BoxView::Document
      end

    end
  end
end