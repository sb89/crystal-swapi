require "./resource"
require "./sub_resource"

module Swapi
  class Planet
    extend Resource
    include SubResource

    JSON.mapping({
      name:                    String,
      diameter:                String,
      rotation_period:         String,
      orbital_period:          String,
      gravity:                 String,
      population:              String,
      climate:                 String,
      terrain:                 String,
      surface_water:           String,
      url:                     String,
      created:                 String,
      edited:                  String,
      films:                   Array(String),
      residents:               Array(String)
    })

    private def self.get_name
      "planets"
    end

    def get_residents
      get_subresource(Person, @residents)
    end

    def get_films
      get_subresource(Film, @films)
    end
  end
end