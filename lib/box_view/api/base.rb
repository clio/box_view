module BoxView
  module Api
    class Base

      attr_accessor :session

      def initialize(session)
        self.session = session
      end

    end
  end
end