require "./spec_helper"

Mocks.create_mock Swapi::Film do
  mock get_subresource(c, urls)
end

module Swapi
  describe Film do
    describe "get" do
      context "with id" do
        it "should return single film" do
          id = 1
          body = Helper.get_film_string

          WebMock.stub(:get, "#{Api::BASE_URL}/films/#{id}/").
            to_return(body: body)

          Film.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of films" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_film_string},#{Helper.get_film_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/films/").
            to_return(body: body)

          Film.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of films" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_film_string},#{Helper.get_film_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/films/?search=#{term}").
          to_return(body: body)

        Film.search(term).to_json.should eq(body)
      end
    end

    describe "get_species" do
      it "should return species" do
        film = Helper.get_film
        film.species = ["url1", "url2"]
        expected_species = [Helper.get_species, Helper.get_species]

        allow(film).to receive(get_subresource(Species, film.species)).and_return(expected_species)

        actual_species = film.get_species

        actual_species.should eq(expected_species)
        film.should have_received(get_subresource(Species, film.species))
      end
    end

    describe "get_starships" do
      it "should return starships" do
        film = Helper.get_film
        film.starships = ["url1", "url2"]
        expected_starships = [Helper.get_starship, Helper.get_starship]

        allow(film).to receive(get_subresource(Starship, film.starships)).and_return(expected_starships)

        actual_starships = film.get_starships

        actual_starships.should eq(expected_starships)
        film.should have_received(get_subresource(Starship, film.starships))
      end
    end

    describe "get_vehicles" do
      it "should return vehicles" do
        film = Helper.get_film
        film.vehicles = ["url1", "url2"]
        expected_vehicles = [Helper.get_vehicle, Helper.get_vehicle]

        allow(film).to receive(get_subresource(Vehicle, film.vehicles)).and_return(expected_vehicles)

        actual_vehicles = film.get_vehicles

        actual_vehicles.should eq(expected_vehicles)
        film.should have_received(get_subresource(Vehicle, film.vehicles))
      end
    end

    describe "get_characters" do
      it "should return people" do
        film = Helper.get_film
        film.characters = ["url1", "url2"]
        expected_characters = [Helper.get_person, Helper.get_person]

        allow(film).to receive(get_subresource(Person, film.characters)).and_return(expected_characters)

        actual_characters = film.get_characters

        actual_characters.should eq(expected_characters)
        film.should have_received(get_subresource(Person, film.characters))
      end
    end

    describe "get_planets" do
      it "should return planets" do
        film = Helper.get_film
        film.planets = ["url1", "url2"]
        expected_planets = [Helper.get_planet, Helper.get_planet]

        allow(film).to receive(get_subresource(Planet, film.planets)).and_return(expected_planets)

        actual_planets = film.get_planets

        actual_planets.should eq(expected_planets)
        film.should have_received(get_subresource(Planet, film.planets))
      end
    end
  end
end