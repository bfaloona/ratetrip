class Rating < ActiveRecord::Base
  belongs_to :driver

  validates_presence_of :quality

end
