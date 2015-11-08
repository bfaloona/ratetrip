class Rating < ActiveRecord::Base
  belongs_to :driver
  has_one :status

  validates_presence_of :quality


end
