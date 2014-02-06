module BoxView
  class Session

    include Http

    attr_accessor :token
    
    def initialize(credentials={})
      self.token = credentials[:token] || self.class.box_view_token
    end

    class << self
      attr_accessor :box_view_token

      def config
        yield self
      end
    end

  end
end