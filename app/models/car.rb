class Car < ApplicationRecord
  include IceCube
  acts_as_bookable time_type: :range

  validates_length_of :license_plate, :minimum => 7, :maximum => 7,:too_short => 'should be 7 characters long.', :too_long => 'should be 7 characters long.', uniqueness: true
  validates_numericality_of(:hourly_rental_rate)

  def self.search(search, search_by)
    where("#{search_by} LIKE ?", "%#{search}%")
  end
end
