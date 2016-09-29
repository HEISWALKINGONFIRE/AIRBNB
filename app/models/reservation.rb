class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing
	has_many :payments

	def dates
		(check_in_date..check_out_date).to_a
	end

	def overlapping_date(booked_dates)
		dates & booked_dates
	end
end


