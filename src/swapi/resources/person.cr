require "./resource"
require "./sub_resource"

module Swapi
  class Person
    extend Resource
    include SubResource

    JSON.mapping({
      name:                 String,
      birth_year:           String,
      eye_color:            String,
      gender:               String,
      height:               String,
      mass:                 String,
      skin_color:           String,
      homeworld:            String,
      films:                Array(String),
      species:              Array(String),
      starships:            Array(String),
      vehicles:             Array(String),
      url:                  String,
      created:              String,
      edited:               String
    })

    private def self.get_name
      "people"
    end

    def get_species
      get_subresource(Species, @species)
    end

    def get_films
      get_subresource(Film, @films)
    end

    def get_starships
      get_subresource(Starship, @starships)
    end

    def get_vehicles
      get_subresource(Vehicle, @vehicles)
    end
  end
end