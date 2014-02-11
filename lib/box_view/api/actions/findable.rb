module BoxView
  module Api
    module Actions
      module Findable

        def find(id)
          data_item(item_from_data(session.get("#{endpoint_url}/#{id}"), :find), session)
        end

        def item_from_data(response_data, action)
          response_data
        end

      end
    end
  end
end