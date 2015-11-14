class Driver < ActiveRecord::Base
  has_many :ratings, dependent: :delete_all

  validates_presence_of   :name
  validates_length_of     :name, :within => 3..25
  validates_presence_of   :permit_number
  validates_uniqueness_of :permit_number

  validates_presence_of :qrcode_path

  before_save :generate_qr_code, on: [:create]

  def photo_path

    nophoto_path = '/images/drivers/nophoto.jpg'
    return nophoto_path if (self.photo.nil? || self.photo.empty?)

    if self.photo.match(/^https?:\/\/.+/)
      # photo value is a url
      return self.photo

    else
      path = "/images/drivers/#{self.photo}"
      if File.exists?(Padrino.root('public') + path)
        return path

      else
        return nophoto_path
      end

    end
  end

  def qrcode_path
    path = "/images/qrcodes/#{self.permit_number}.png"
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
      qrcode = RQRCode::QRCode.new("http://#{Rateride::App.settings.site_domain}/#{self.permit_number}")
      path = "/images/qrcodes/#{self.permit_number}.png"
      qrcode.as_png(file: Padrino.root('public') + path)
    end

end
