require "./resource"
require "./sub_resource"

module Swapi
  class Film
    extend Resource
    include SubResource

      JSON.mapping({
        title:               String,
        episode_id:          UInt8,
        opening_crawl:       String,
        director:            String,
        producer:            String,
        release_date:        String,
        species:             Array(String),
        starships:           Array(String),
        vehicles:            Array(String),
        characters:          Array(String),
        planets:             Array(String),
        url:                 String,
        created:             String,
        edited:              String
      })

      private def self.get_name
        "films"
      end

      def get_species
        get_subresource(Species, @species)
      end

      def get_starships
        get_subresource(Starship, @starships)
      end

      def get_vehicles
        get_subresource(Vehicle, @vehicles)
      end

      def get_characters
        get_subresource(Person, @characters)
      end

      def get_planets
        get_subresource(Planet, @planets)
      end
  end
end