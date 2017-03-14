require "spec"
require "webmock"
require "mocks"
require "mocks/spec"
require "../src/swapi"

module Helper
  extend self

  @@planet_string = JSON.build do |json|
    json.object do
      json.field "name", "Tatooine"
      json.field "diameter", "400"
      json.field "rotation_period", "5"
      json.field "orbital_period", "278"
      json.field "gravity", "1"
      json.field "population", "500000"
      json.field "climate", "Arid"
      json.field "terrain", "Desert"
      json.field "surface_water", "50"
      json.field "url", "Url..."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
      json.field "films" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "residents" do
        json.array do
          json.string "Url..."
        end
      end
    end
  end

  def get_planet_string
    @@planet_string
  end

  def get_planet
    Swapi::Planet.new(JSON::PullParser.new(@@planet_string))
  end


  @@person_string = JSON.build do |json|
    json.object do
      json.field "name", "name"
      json.field "birth_year", "0"
      json.field "eye_color", "green"
      json.field "gender", "male"
      json.field "height", "1.73"
      json.field "mass", "100"
      json.field "skin_color", "green"
      json.field "homeworld", "Dantooine"
      json.field "films" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "species" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "starships" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "vehicles" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "url", "Url..."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
    end
  end

  def get_person_string
    @@person_string
  end

  def get_person
    Swapi::Person.new(JSON::PullParser.new(@@person_string))
  end

  @@vehicle_string = JSON.build do |json|
    json.object do
      json.field "name", "name"
      json.field "model", "model"
      json.field "vehicle_class", "vehicle_class"
      json.field "manufacturer", "manufacturer"
      json.field "cost_in_credits", "5000"
      json.field "length", "100"
      json.field "crew", "crew..."
      json.field "passengers", "passengers..."
      json.field "max_atmosphering_speed", "100"
      json.field "cargo_capacity", "500"
      json.field "consumables", "consumables..."
      json.field "films" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "pilots" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "url", "Url..."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
    end
  end

  def get_vehicle_string
    @@vehicle_string
  end

  def get_vehicle
    Swapi::Vehicle.new(JSON::PullParser.new(@@vehicle_string))
  end

  @@starship_string = JSON.build do |json|
    json.object do
      json.field "name", "name"
      json.field "model", "model"
      json.field "starship_class", "starship_class"
      json.field "manufacturer", "manufacturer"
      json.field "cost_in_credits", "5000"
      json.field "length", "100"
      json.field "crew", "crew..."
      json.field "passengers", "passengers..."
      json.field "max_atmosphering_speed", "100"
      json.field "hyperdrive_rating", "10"
      json.field "MGLT", "10"
      json.field "cargo_capacity", "500"
      json.field "consumables", "consumables..."
      json.field "films" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "pilots" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "url", "Url..."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
    end
  end

  def get_starship_string
    @@starship_string
  end

  def get_starship
    Swapi::Starship.new(JSON::PullParser.new(@@starship_string))
  end

  @@species_string = JSON.build do |json|
    json.object do
      json.field "name", "name"
      json.field "classification", "classification"
      json.field "designation", "designation"
      json.field "average_height", "6"
      json.field "average_lifespan", "80"
      json.field "eye_colors", "blue, green, brown"
      json.field "hair_colors", "brown, grey, red, blonde, black"
      json.field "skin_colors", "white, black, brown"
      json.field "language", "English"
      json.field "homeworld", "Earth"
      json.field "people" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "films" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "url", "Url..."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
    end
  end

  def get_species_string
    @@species_string
  end

  def get_species
    Swapi::Species.new(JSON::PullParser.new(@@species_string))
  end

  @@film_string = JSON.build do |json|
    json.object do
      json.field "title", "title"
      json.field "episode_id", 1
      json.field "opening_crawl", "Crawl..."
      json.field "director", "Director"
      json.field "producer", "producer"
      json.field "release_date", "01/01/90"
      json.field "species" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "starships" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "vehicles" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "characters" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "planets" do
        json.array do
          json.string "Url..."
        end
      end
      json.field "url", "Url.."
      json.field "created", "01/01/2017.."
      json.field "edited", "01/01/2017.."
    end
  end

  def get_film_string
    @@film_string
  end

  def get_film
    Swapi::Film.new(JSON::PullParser.new(@@film_string))
  end
end
