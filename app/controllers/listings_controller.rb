class ListingsController < ApplicationController
	
		
	
	def new

		@listing = Listing.new
	end

	def confirm
		@listing = Listing.new(listing_params)
		render 'confirm'
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to listing_path(@listing.id)
			# render listing_path(@listing.id)
			# redirect_to '/listings/show/#{@listing.id}'
		else
			redirect_to new_listing_path 
			# render :new
			# render '/listings/new'
		end
		
	end

	def show
		@listing = Listing.find(params[:id])
		
	end

	def index
		listing_per_page = 5
		first_listing = 0 unless params[:page]
		first_listing = (params[:page].to_i-1) * listing_per_page
		listings = Listing.all
		@total_pages = Listing.all.count / listing_per_page
		if listings.count % listing_per_page > 0
			@total_pages += 1
		else
		end
		@listings = listings[first_listing...(first_listing + listing_per_page )]
	end

	

	private 

	def listing_params
		params.require(:listing).permit(:name, :location, :price, :num_of_people, :user_id, {avatars:[]})
	end

end


#With using active record assiociation you are able to link tables tgt (in your model file, u specify that Listing belongs_to :user, and User has_many :listings)

# This allows you to query data such as current_user.listings (returns u all the listing create by the current_user)
# You also can query who create a specific listing (listing = Listing.find(1) listing.user) #this returns u the user that created the specific listing