module BoxView
  module Api
    class Base

      attr_accessor :session

      def initialize(session)
        self.session = session
      end

      private
      def data_item(params, session)
        data_klass.new(params, session)
      end

    end
  end
end