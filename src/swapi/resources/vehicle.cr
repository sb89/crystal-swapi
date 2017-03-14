require "./resource"
require "./sub_resource"

module Swapi
  class Vehicle
    extend Resource
    include SubResource

    JSON.mapping({
      name:                     String,
      model:                    String,
      vehicle_class:            String,
      manufacturer:             String,
      cost_in_credits:          String,
      length:                   String,
      crew:                     String,
      passengers:               String,
      max_atmosphering_speed:   String,
      cargo_capacity:           String,
      consumables:              String,
      films:                    Array(String),
      pilots:                   Array(String),
      url:                      String,
      created:                  String,
      edited:                   String
    })

    private def self.get_name
      "vehicles"
    end

    def get_films
      get_subresource(Film, @films)
    end

    def get_pilots
      get_subresource(Person, @pilots)
    end
  end
end