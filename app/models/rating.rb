class Rating < ActiveRecord::Base
  belongs_to :driver

  validates_presence_of :quality
  validates_presence_of :driver_id
  validates_presence_of :status_id

end
