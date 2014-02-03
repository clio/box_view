module BoxView
  class DocumentSession < Base
    
    attr_accessor :type, :id, :expires_at

    def view_url(theme = "dark")
      "https://view-api.box.com/view/#{self.id}?theme=#{theme}"
    end
  end
end