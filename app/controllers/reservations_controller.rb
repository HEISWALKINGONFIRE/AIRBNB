class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = @listing.id
		@host = "noprogrammerlikeme@gmail.com"
		booked_dates = @listing.booked_dates
		if   @reservation.overlapping_date(booked_dates).empty? && @reservation.save
			#this checks if the booked_dates are empty, if is empty then it will create a new reservation
			#once im able to create a new reservation, i would need to add my listing_id into my reservation as i only have user_id for now (current_user.reservations)
			 @reservation.update(listing_id: @listing.id)
			 ReservationMailer.notification_email(current_user.email, @host, @reservation.listing.id, @reservation.id).deliver_now
			 ReservationJob.perform_later(current_user.email, @host, @reservation.listing.id, @reservation.id)
			redirect_to reservation_confirm_path(@reservation.id)
			
		else
			flash[:notice] = "dates are not available on #{@reservation.overlapping_dates(booked_dates)}"

			redirect_to new_reservation_path
		end
	end

	def index
	end 

	def confirm
		@reservation = Reservation.find(params[:reservation_id])
	end

	private 

	def reservation_params
		params.require(:reservation).permit( :listing_id, :user_id, :price, :check_in_date, :check_out_date)
	end



end


