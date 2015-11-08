class Status < ActiveRecord::Base
  has_many :rating

  validates_presence_of :description
end
