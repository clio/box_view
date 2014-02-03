module BoxView
  class Document < Base

    attr_accessor :type, :id, :status, :name, :created_at, :modified_at

    def document_session
      @document_session ||= BoxView::Api::DocumentSession.new(session).create(self.id)
    end
    
  end
end