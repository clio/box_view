module BoxView
  class Document < Base

    attr_accessor :type, :id, :status, :name, :created_at, :modified_at

    def document_session
      @document_session ||= BoxView::Api::DocumentSession.new(session).create(self.id)
    end

   def thumbnail(width, height, filename=self.id)
      @thumbnail ||= BoxView::Api::Document.new(session).thumbnail(self.id, width, height, "#{self.id}.png")
   end

  end
end