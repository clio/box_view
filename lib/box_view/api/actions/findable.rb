module BoxView
  module Api
    module Actions
      module Findable

        def find(id)
          data_item(item_from_data(session.get("#{endpoint_url}/#{id}"), :find), session)
        end
      end
    end
  end
end