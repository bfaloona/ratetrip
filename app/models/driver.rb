class Driver < ActiveRecord::Base
  has_many :ratings

  validates_presence_of :name
  validates_presence_of :permit_number

end
