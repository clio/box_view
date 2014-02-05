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

      def data_klass
        raise NotImplementedError.new
      end

    end
  end
end