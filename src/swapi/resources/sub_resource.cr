require "../api"

module Swapi
    private module SubResource
      private def get_subresource(resource : T.class, urls) forall T
        urls.map do |x| 
          data = Api.execute_request x
          T.from_json(data) 
        end
      end
    end
end