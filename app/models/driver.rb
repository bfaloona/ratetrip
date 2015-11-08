class Driver < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :permit_number

end
