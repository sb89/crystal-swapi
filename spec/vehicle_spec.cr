require "./spec_helper"

Mocks.create_mock Swapi::Vehicle do
  mock get_subresource(c, urls)
end

module Swapi
  describe Vehicle do
    describe "get" do
      context "with id" do
        it "should return single vehicle" do
          id = 1
          body = Helper.get_vehicle_string

          WebMock.stub(:get, "#{Api::BASE_URL}/vehicles/#{id}/").
            to_return(body: body)

          Vehicle.get(id).to_json.should eq(body)
        end
      end

      context "without id" do
        it "should return list of vehicles" do
          body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_vehicle_string},#{Helper.get_vehicle_string}]}"

          WebMock.stub(:get, "#{Api::BASE_URL}/vehicles/").
            to_return(body: body)

          Vehicle.get.to_json.should eq(body)
        end
      end
    end

    describe "search" do
      it "should return list of vehicles" do
        term = "term"
        body = "{\"count\":2,\"next\":\"url1\",\"previous\":\"url2\",\"results\":[#{Helper.get_vehicle_string},#{Helper.get_vehicle_string}]}"

        WebMock.stub(:get, "#{Api::BASE_URL}/vehicles/?search=#{term}").
          to_return(body: body)

        Vehicle.search(term).to_json.should eq(body)
      end
    end

    describe "get_pilots" do
      it "should return people" do
        vehicle = Helper.get_vehicle
        vehicle.pilots = ["url1", "url2"]
        expected_people = [Helper.get_person, Helper.get_person]

        allow(vehicle).to receive(get_subresource(Person, vehicle.pilots)).and_return(expected_people)

        actual_people = vehicle.get_pilots

        actual_people.should eq(expected_people)
        vehicle.should have_received(get_subresource(Person, vehicle.pilots))
      end
    end

    describe "get_films" do
      it "should return films" do
        vehicle = Helper.get_vehicle
        vehicle.films = ["url1", "url2"]
        expected_films = [Helper.get_film, Helper.get_film]

        allow(vehicle).to receive(get_subresource(Film, vehicle.films)).and_return(expected_films)

        actual_films = vehicle.get_films

        actual_films.should eq(expected_films)
        vehicle.should have_received(get_subresource(Film, vehicle.films))
      end
    end
  end
end