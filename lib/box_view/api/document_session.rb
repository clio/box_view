module BoxView
  module Api
    class DocumentSession < Base

      def create(document_id)
        data_item(session.post("sessions", { document_id: document_id }.to_json), session)
      end

      def data_klass
        BoxView::DocumentSession
      end

    end
  end
end