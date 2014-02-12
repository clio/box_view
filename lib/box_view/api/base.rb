module BoxView
  module Api
    class Base

      attr_accessor :session

      def initialize(session=nil)
        self.session = session || BoxView::Session.new
      end

      private

      def data_item(params, session)
        data_klass.new(params, session)
      end

      def data_klass
        raise NotImplementedError.new
      end

      def item_from_data(response_data, action)
        response_data
      end
    end
  end
end