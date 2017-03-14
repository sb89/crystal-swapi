module Swapi
  private module Api
    extend self
    
    BASE_URL = "http://swapi.co/api"

    def get_url(type, id = nil)
      url = "#{BASE_URL}/#{type}/"
      url += "#{id}/" if id

      execute_request url
    end

    def search_url(type, term)
      execute_request "#{BASE_URL}/#{type}/?search=#{term}"
    end

    def execute_request(url)
      response = HTTP::Client.get url

      case response.status_code
      when 200
        response.body
      else
        raise Exception.new("Received #{response.status_code} status.")
      end
    end
    
  end
end