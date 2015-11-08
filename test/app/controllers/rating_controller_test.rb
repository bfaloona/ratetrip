require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "/rating" do
  before do
    get "/rating"
  end

  it "should return list of ratings" do
    last_response.body.split('RateTrip ratings').count.must_equal 2
  end
end
