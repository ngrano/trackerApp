class Location < ActiveRecord::Base
  validates_presence_of :longtitude, :latitude

  belongs_to :user
end
