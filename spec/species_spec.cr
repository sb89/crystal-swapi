require "./spec_helper"

Mocks.create_mock Swapi::Species do
  mock get_subresource(c, urls)
end

module Swapi
  describe Species do
    describe "get" do
      context "with id" do
        it "should return single species" do
          id = 1
          body = Helper.get_species_string

          WebMock.stub(:get, "#{Api::BASE_URL}/species/#{id}/").
            to_return(body: body)

          Species.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of species" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_species_string},#{Helper.get_species_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/species/").
            to_return(body: body)

          Species.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of species" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_species_string},#{Helper.get_species_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/species/?search=#{term}").
          to_return(body: body)

        Species.search(term).to_json.should eq(body)
      end
    end

    describe "get_people" do
      it "should return people" do
        species = Helper.get_species
        species.people = ["url1", "url2"]
        expected_people = [Helper.get_person, Helper.get_person]

        allow(species).to receive(get_subresource(Person, species.people)).and_return(expected_people)

        actual_people = species.get_people

        actual_people.should eq(expected_people)
        species.should have_received(get_subresource(Person, species.people))
      end
    end

    describe "get_films" do
      it "should return films" do
        species = Helper.get_species
        species.films = ["url1", "url2"]
        expected_films = [Helper.get_film, Helper.get_film]

        allow(species).to receive(get_subresource(Film, species.films)).and_return(expected_films)

        actual_films = species.get_films

        actual_films.should eq(expected_films)
        species.should have_received(get_subresource(Film, species.films))
      end
    end
  end
end