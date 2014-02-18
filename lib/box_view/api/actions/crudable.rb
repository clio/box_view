module BoxView
  module Api
    module Actions
      module Crudable

        def create(params)
          data_item(session.post(endpoint_url, session.convert_params(params).to_json), session)
        end

        def update(id, params)
          data_item(session.put("#{endpoint_url}/#{id}", session.convert_params(params).to_json), session)
        end

        def destroy(id)
          session.delete("#{endpoint_url}/#{id}", false)
        end
      end
    end
  end
end