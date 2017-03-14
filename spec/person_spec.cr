require "./spec_helper"

Mocks.create_mock Swapi::Person do
  mock get_subresource(c, urls)
end

module Swapi
  describe Person do
    describe "get" do
      context "with id" do
        it "should return single person" do
          id = 1
          body = Helper.get_person_string

          WebMock.stub(:get, "#{Api::BASE_URL}/people/#{id}/").
            to_return(body: body)

          Person.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of people" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_person_string},#{Helper.get_person_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/people/").
            to_return(body: body)

          Person.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of people" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_person_string},#{Helper.get_person_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/people/?search=#{term}").
          to_return(body: body)

        Person.search(term).to_json.should eq(body)
      end
    end

    describe "get_starships" do
      it "should return starships" do
        person = Helper.get_person
        person.starships = ["url1", "url2"]
        expected_starships = [Helper.get_starship, Helper.get_starship]

        allow(person).to receive(get_subresource(Starship, person.starships)).and_return(expected_starships)

        actual_starships = person.get_starships

        actual_starships.should eq(expected_starships)
        person.should have_received(get_subresource(Starship, person.starships))
      end
    end

    describe "get_vehicles" do
      it "should return vehicles" do
        person = Helper.get_person
        person.vehicles = ["url1", "url2"]
        expected_vehicles = [Helper.get_vehicle, Helper.get_vehicle]

        allow(person).to receive(get_subresource(Vehicle, person.vehicles)).and_return(expected_vehicles)

        actual_vehicles = person.get_vehicles

        actual_vehicles.should eq(expected_vehicles)
        person.should have_received(get_subresource(Vehicle, person.vehicles))
      end
    end

    describe "get_species" do
      it "should return species" do
        person = Helper.get_person
        person.species = ["url1", "url2"]
        expected_species = [Helper.get_species, Helper.get_species]

        allow(person).to receive(get_subresource(Species, person.species)).and_return(expected_species)

        actual_species = person.get_species

        actual_species.should eq(expected_species)
        person.should have_received(get_subresource(Species, person.species))
      end
    end

    describe "get_films" do
      it "should return films" do
        person = Helper.get_person
        person.films = ["url1", "url2"]
        expected_films = [Helper.get_film, Helper.get_film]

        allow(person).to receive(get_subresource(Film, person.films)).and_return(expected_films)

        actual_films = person.get_films

        actual_films.should eq(expected_films)
        person.should have_received(get_subresource(Film, person.films))
      end
    end
  end
end