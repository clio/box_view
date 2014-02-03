module BoxView
  class Session

    include Http

    attr_accessor :token
    
    def initialize(credentials={})
      self.token = credentials[:token]
    end

  end
end