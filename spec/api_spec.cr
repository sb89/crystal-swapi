require "./spec_helper"

module Swapi

  describe Api do
    describe "get_url" do
      context "with id specified" do
        it "performs http request" do
          type = "random_type"
          id = 5
          body = "Random body"
          
          WebMock.stub(:get, "#{Api::BASE_URL}/#{type}/#{id}/").
            to_return(body: body)

          data = Api.get_url(type, id)

          data.should eq(body)
        end
      end

      context "without id" do
        it "performs http request" do
          type = "random_type"
          body = "Random body"
          
          WebMock.stub(:get, "#{Api::BASE_URL}/#{type}/").
            to_return(body: body)

          data = Api.get_url(type)

          data.should eq(body)
        end
      end
    end

    describe "execute_request" do
      it "performs http request" do
        url = "url..."
        body = "Random body"
        
        WebMock.stub(:get, url).
          to_return(body: body)

        data = Api.execute_request(url)

        data.should eq(body)
      end

      it "exceptions when non-200 status is returned" do
        expect_raises(Exception, "Received 500 status.") do
          WebMock.stub(:get, "random url").to_return(status: 500)

          Api.execute_request("random url")
        end
      end
    end
  end
end