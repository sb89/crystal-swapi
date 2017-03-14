require "./spec_helper"

Mocks.create_mock Swapi::Starship do
  mock get_subresource(c, urls)
end

module Swapi
  describe Starship do
    describe "get" do
      context "with id" do
        it "should return single starship" do
          id = 1
          body = Helper.get_starship_string

          WebMock.stub(:get, "#{Api::BASE_URL}/starships/#{id}/").
            to_return(body: body)

          Starship.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of starships" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_starship_string},#{Helper.get_starship_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/starships/").
            to_return(body: body)

          Starship.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of starships" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_starship_string},#{Helper.get_starship_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/starships/?search=#{term}").
          to_return(body: body)

        Starship.search(term).to_json.should eq(body)
      end
    end

    describe "get_pilots" do
      it "should return people" do
        starship = Helper.get_starship
        starship.pilots = ["url1", "url2"]
        expected_people = [Helper.get_person, Helper.get_person]

        allow(starship).to receive(get_subresource(Person, starship.pilots)).and_return(expected_people)

        actual_people = starship.get_pilots

        actual_people.should eq(expected_people)
        starship.should have_received(get_subresource(Person, starship.pilots))
      end
    end

    describe "get_films" do
      it "should return films" do
        starship = Helper.get_starship
        starship.films = ["url1", "url2"]
        expected_films = [Helper.get_film, Helper.get_film]

        allow(starship).to receive(get_subresource(Film, starship.films)).and_return(expected_films)

        actual_films = starship.get_films

        actual_films.should eq(expected_films)
        starship.should have_received(get_subresource(Film, starship.films))
      end
    end
  end
end