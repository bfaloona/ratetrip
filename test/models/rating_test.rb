require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Rating Model" do
  it 'can construct a new instance' do
    @rating = Rating.new
    refute_nil @rating
  end
end
