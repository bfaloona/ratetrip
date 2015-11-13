require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Controller" do
  before do
    get "/"
  end

  it "should return welcome message" do
    last_response.body.split('Instructions').count.must_equal 2
  end
end
