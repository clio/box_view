module BoxView
  module Api
    class Document < Base

      def list(limit=nil, created_before=nil, created_after=nil)
        params = {}
        params[:limit] = limit if !limit.nil?
        params[:created_before] = created_before.iso8601 if !created_before.nil?
        params[:created_after] = created_after.iso8601 if !created_after.nil?

        docs = session.get("documents", params)["document_collection"]["entries"].collect{ |doc| data_item(doc, session) }
      end

      def find(id)
        data_item(session.get("documents/#{id}"), session)
      end

      def update(id, params)
        data_item(session.put("documents/#{id}", params.to_json), session)
      end

      def destroy(id)
        session.delete("documents/#{id}", false)
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

      private

      def data_klass
        BoxView::Document
      end

    end
  end
end