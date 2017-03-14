require "./spec_helper"

Mocks.create_mock Swapi::Planet do
  mock get_subresource(c, urls)
end

module Swapi
  describe Planet do
    describe "get" do
      context "with id" do
        it "should return single planet" do
          id = 1
          body = Helper.get_planet_string

          WebMock.stub(:get, "#{Api::BASE_URL}/planets/#{id}/").
            to_return(body: body)

          Planet.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of planets" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_planet_string},#{Helper.get_planet_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/planets/").
            to_return(body: body)

          Planet.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of planets" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_planet_string},#{Helper.get_planet_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/planets/?search=#{term}").
          to_return(body: body)

        Planet.search(term).to_json.should eq(body)
      end
    end

    describe "get_films" do
      it "should return films" do
        planet = Helper.get_planet
        planet.films = ["url1", "url2"]
        expected_films = [Helper.get_film, Helper.get_film]

        allow(planet).to receive(get_subresource(Film, planet.films)).and_return(expected_films)

        actual_films = planet.get_films

        actual_films.should eq(expected_films)
        planet.should have_received(get_subresource(Film, planet.films))
      end
    end

    describe "get_residents" do
      it "should return people" do
        planet = Helper.get_planet
        planet.residents = ["url1", "url2"]
        expected_people = [Helper.get_person, Helper.get_person]

        allow(planet).to receive(get_subresource(Person, planet.residents)).and_return(expected_people)

        actual_people = planet.get_residents

        actual_people.should eq(expected_people)
        planet.should have_received(get_subresource(Person, planet.residents))
      end
    end
  end
end