module BoxView
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

   def thumbnail(width, height, filename=self.id)
      @thumbnail ||= BoxView::Api::Document.new(session).thumbnail(self.id, width, height, "#{self.id}.png")
   end

  end
end