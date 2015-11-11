require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Driver Model" do

  before do

    # Clean up
    Driver.delete_all
    qrcode_file = PADRINO_ROOT + '/public/images/drivers/736288261349.png'
    File.delete qrcode_file if File.exists?( qrcode_file )
    File.exists?(qrcode_file).must_equal false

    @driver = Driver.new
    @driver.name = 'Test User'
    @driver.permit_number = '736288261349'
    @driver.photo = 'testuser.png'
    @driver.save
  end

  it 'can save properties' do
    @driver.name.must_equal 'Test User'
    @driver.permit_number.must_equal '736288261349'
    @driver.photo.must_equal 'testuser.png'
  end

  it 'can save qrcode image path name' do
    @driver.qrcode_path.must_include '736288261349'
  end

  it 'can create qrcode image file' do
    qrcode_file = File.expand_path(File.dirname(__FILE__) + '/../../public/images/drivers/736288261349.png')
    assert File.exists?(qrcode_file)

    assert( File.exists?( File.expand_path(File.dirname(__FILE__) + '/../../public/' + @driver.qrcode_path)),
        'Fail: QR Code image file not found')
  end
end

describe "Driver validation" do

  before do
    # Clean up
    Driver.delete_all
    @driver = Driver.new
  end

  it 'requires name' do
    @driver.permit_number = '736288261349'
    @driver.photo = 'testuser.png'
    assert !@driver.valid?
    assert_equal [:name], @driver.errors.keys
  end

  it 'requires permit_number' do
    @driver.name = 'Test User'
    @driver.photo = 'testuser.png'
    assert !@driver.valid?
    assert_equal [:permit_number], @driver.errors.keys
  end

  it 'does not require photo' do
    @driver.name = 'Test User'
    @driver.permit_number = '736288261349'
    @driver.valid?
    assert_equal [], @driver.errors.keys
    @driver.save
    assert true, '@driver.save failed'
  end

end
