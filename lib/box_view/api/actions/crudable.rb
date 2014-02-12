module BoxView
  module Api
    module Actions
      module Crudable

        def create(params)
          data_item(item_from_data(session.post(endpoint_url, session.convert_params(params).to_json), :create), session)
        end

        def update(id, params)
          data_item(item_from_data(session.put("#{endpoint_url}/#{id}", session.convert_params(params).to_json), :update), session)
        end

        def destroy(id)
          session.delete("#{endpoint_url}/#{id}", false)
        end
      end
    end
  end
end