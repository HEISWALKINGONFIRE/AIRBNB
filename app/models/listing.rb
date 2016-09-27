class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :reservations
  mount_uploaders :avatars, AvatarUploader


	def booked_dates
		dates_that_are_booked = []
		self.reservations.each do |reservation|
			reservations.each do |date|
				dates_that_are_booked << date
			end
		end
		return dates_that_are_booked
	end
  

end


