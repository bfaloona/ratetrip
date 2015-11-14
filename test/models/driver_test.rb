require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Driver Model" do

  before do

    # Clean up
    Driver.delete_all
    qrcode_file = PADRINO_ROOT + '/public/images/qrcodes/736288261349.png'
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
    qrcode_file = File.expand_path(File.dirname(__FILE__) + '/../../public/images/qrcodes/736288261349.png')
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

describe "Driver photo_path" do

  before do
    # Clean up
    Driver.delete_all
    @driver = Driver.new
    @driver.name = 'Test User'
    @driver.permit_number = '736288261349'
  end

  it 'returns value when photo is found' do
    @driver.photo = 'whudson.jpg'
    @driver.save
    @driver.photo_path.must_equal '/images/drivers/whudson.jpg'
  end

  it 'returns nophoto.jpg when photo is blank' do
    @driver.save
    @driver.photo_path.must_equal '/images/drivers/nophoto.jpg'
  end

  it 'returns nophoto.jpg when photo is not found' do
    @driver.photo = 'blah'
    @driver.save
    @driver.photo_path.must_equal '/images/drivers/nophoto.jpg'
  end

  it 'returns value when set to http URL' do
    @driver.photo = 'http://foo.jpg'
    @driver.save
    @driver.photo_path.must_equal 'http://foo.jpg'
  end

  it 'returns value when set to https URL' do
    @driver.photo = 'https://foo.jpg'
    @driver.save
    @driver.photo_path.must_equal 'https://foo.jpg'
  end

end