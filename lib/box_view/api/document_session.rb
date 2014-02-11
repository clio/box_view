module BoxView
  module Api
    class DocumentSession < Base

      include BoxView::Api::Actions::Crudable

      def update(*args)
        raise NotImplementedException
      end

      def destroy(*args)
        raise NotImplementedException
      end

      private

      def data_klass
        BoxView::Models::DocumentSession
      end

      def endpoint_url; "sessions"; end

    end
  end
end