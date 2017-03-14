require "./spec_helper"

module Swapi
  describe Swapi::List do
    describe "next?" do
      context "when no next" do
        it "should return false" do
          list = Swapi::List(Swapi::Film).new

          list.next?.should be_false
        end
      end

      context "when there is next" do
        it "should return true" do
          list = Swapi::List(Swapi::Film).new
          list.next = "random url"

          list.next?.should be_true
        end
      end
    end

    describe "previous?" do
      context "when no previous" do
        it "should return false" do
          list = Swapi::List(Swapi::Film).new

          list.previous?.should be_false
        end
      end

      context "when there is next" do
        it "should return true" do
          list = Swapi::List(Swapi::Film).new
          list.previous = "random url"

          list.previous?.should be_true
        end
      end
    end

    describe "next" do
      context "when there is no next" do
        it "should return empty list" do
          list = Swapi::List(Swapi::Film).new

          n = list.get_next

          n.count.should eq(0)
          n.results.size.should eq(0)
        end
      end

      context "when there is next" do
        it "should return populated list" do
          list = Swapi::List(Swapi::Film).new
          list.next = "url"

          WebMock.stub(:get, "url").
            to_return(body: "{\"count\":1, \"next\":\"url1\", \"previous\":\"url2\", \"results\": [#{Helper.get_film_string}]}")

          actualList = list.get_next

          actualList.count.should eq(1)
          actualList.next.should eq("url1")
          actualList.previous.should eq("url2")
          actualList.results.size.should eq(1)
          actualList.results[0].to_json.should eq(Helper.get_film_string)
        end
      end
    end

    describe "previous" do
      context "when there is no previous" do
        it "should return empty list" do
          list = Swapi::List(Swapi::Film).new

          n = list.get_previous

          n.count.should eq(0)
          n.results.size.should eq(0)
        end
      end

      context "when there is previous" do
        it "should return populated list" do
          list = Swapi::List(Swapi::Film).new
          list.previous = "url"

          WebMock.stub(:get, "url").
            to_return(body: "{\"count\":1, \"next\":\"url1\", \"previous\":\"url2\", \"results\": [#{Helper.get_film_string}]}")

          actualList = list.get_previous

          actualList.count.should eq(1)
          actualList.next.should eq("url1")
          actualList.previous.should eq("url2")
          actualList.results.size.should eq(1)
          actualList.results[0].to_json.should eq(Helper.get_film_string)
        end
      end
    end
  end
end