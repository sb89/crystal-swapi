require "./resource"
require "./sub_resource"

module Swapi
  class Species
    extend Resource
    include SubResource

    JSON.mapping({
      name:                    String,
      classification:          String,
      designation:             String,
      average_height:          String,
      average_lifespan:        String,
      eye_colors:              String,
      hair_colors:             String,
      skin_colors:             String,
      language:                String,
      homeworld:               String,
      people:                  Array(String),
      films:                   Array(String),
      url:                     String,
      created:                 String,
      edited:                  String
    })

    private def self.get_name
      "species"
    end

    def get_people
      get_subresource(Person, @people)
    end

    def get_films
      get_subresource(Film, @films)
    end
  end
end