module BoxView
  module Api
    module Actions
      module Listable

        def list(params={})
          session.get(endpoint_url, params)["document_collection"]["entries"].collect{ |item| data_item(item, session) }
        end
      end
    end
  end
end