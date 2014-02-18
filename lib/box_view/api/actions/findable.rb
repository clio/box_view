module BoxView
  module Api
    module Actions
      module Findable

        def find(id)
          data_item(session.get("#{endpoint_url}/#{id}"), session)
        end
      end
    end
  end
end