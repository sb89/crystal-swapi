module Swapi
  class List(T)
    JSON.mapping({
      count:                Int32,
      next:                 String?,
      previous:             String?,
      results:              Array(T)
    })

    def initialize
      @count = 0
      @results = Array(T).new
    end

    def next?
      !@next.nil?
    end

    def previous?
      !@previous.nil?
    end

    def get_next
      get(@next)
    end

    def get_previous
      get(@previous)
    end

    private def get(direction)
      l = List(T)

      direction.nil? ? l.new : l.from_json(Api.execute_request(direction))
    end
  end
end