require "../api"
require "./list"

module Swapi
  private module Resource

    abstract def get_name : String

    def get
      data = Api.get_url(get_name)

      List(self).from_json(data)
    end

    def get(id)
      data = Api.get_url(get_name, id)

      self.from_json(data)
    end

    def search(term)
      data = Api.search_url(get_name, term)

      List(self).from_json(data)
    end
  end
end