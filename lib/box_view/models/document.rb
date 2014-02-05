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
        @document_session ||= BoxView::Api::DocumentSession.new(session).create(self.id)
      end

      def thumbnail(width, height, filename="#{self.id}.png")
        @thumbnail ||= BoxView::Api::Document.new(session).thumbnail(self.id, width, height, filename)
      end

      def content(filename="#{self.id}.zip")
        BoxView::Api::Document.new(session).content(self.id, filename)
      end

      def to_params
        { name: self.name }
      end

      def api
        BoxView::Api::Document.new(session)
      end

    end
  end
end