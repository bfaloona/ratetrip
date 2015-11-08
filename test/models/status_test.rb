require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Status Model" do
  it 'can construct a new instance' do
    @status = Status.new
    refute_nil @status
  end
end
