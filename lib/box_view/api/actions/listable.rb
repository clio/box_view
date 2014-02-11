module BoxView
  module Api
    module Actions
      module Listable

        def list(params={})
          item_from_data(session.get(endpoint_url, params), :list).collect{ |item| data_item(item, session) }
        end

        def item_from_data(response_data, action)
          response_data
        end

      end
    end
  end
end