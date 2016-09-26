class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create
		@listing = Listing.find(params[:listing_id])
		@reservations = current_user.reservations.new(reservation_params)
		@reservations.listing_id = @listing.id
		if @reservations.save
			redirect_to reservation_confirm_path(@reservations.id)
		else
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
