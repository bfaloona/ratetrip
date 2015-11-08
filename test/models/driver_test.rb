require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Driver Model" do
  it 'can construct a new instance' do
    @driver = Driver.new
    refute_nil @driver
  end
end
