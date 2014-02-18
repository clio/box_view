module BoxView
  module Models
    class Document < Base

      has_attributes(
        type:        { type: :string },
        id:          { type: :string },
        status:      { type: :string },
        name:        { type: :name },
        created_at:  { type: :datetime, readonly: true },
        modified_at: { type: :datetime, readonly: true }
      )

      def document_session
        @document_session ||= BoxView::Api::DocumentSession.new(session).create(document_id: self.id)
      end

      def thumbnail(width, height)
        self.api.thumbnail(self.id, width, height)
      end

      def content(extension=nil)
        self.api.content(self.id, extension)
      end

      def to_params
        { name: self.name }
      end

      def api
        @api ||= BoxView::Api::Document.new(session)
      end

    end
  end
end