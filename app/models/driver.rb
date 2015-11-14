class Driver < ActiveRecord::Base
  has_many :ratings, dependent: :delete_all

  validates_presence_of :name
  validates_presence_of :permit_number
  validates_uniqueness_of :permit_number

  validates_presence_of :qrcode_path

  before_save :generate_qr_code, on: [:create]

  def photo_path
    path = "/images/drivers/#{self.photo}"
    if self.photo && File.exists?(Padrino.root('public') + path)
      return path
    else
      return '/images/drivers/nophoto.jpg'
    end
  end

  def qrcode_path
    path = "/images/drivers/#{self.permit_number}.png"
    if !File.exists? Padrino.root('public') + path
      self.generate_qr_code
      path
    else
      path
    end
  end

  protected
    def generate_qr_code
      require 'rqrcode'
      qrcode = RQRCode::QRCode.new("https://ratetrip.herokuapp.com/#{self.permit_number}")
      path = '/images/drivers/' + self.permit_number.to_s + '.png'
      qrcode.as_png(file: Padrino.root('public') + path)
    end

end
