class ProvidersController < ApplicationController

	before_action :check_provider_login, except: [:new, :create]

	def new
		@provider = Provider.new
	end

	def create
		@provider = Provider.new(provider_params)

		if @provider.save
			redirect_to provider_path(@provider)
		else
			render action: :new
		end
	end

	def show
		@provider = Provider.find(params[:id])
		@provider_events = @provider.events
	end
	
	#
	def events
	    @events = @current_provider.events
	    respond_to do |format|
	      format.html # show.html.erb
	      format.xml  { render :xml => @events }
	      format.js { render :json => @events.to_json }
	    end
	end
	#
	
	def edit
		
	end

	def update
		@current_provider.update_attributes(provider_params)
		redirect_to provider_path(@current_provider)
	end

	def confirm
		head :ok
	end

	private

	def provider_params
		params.require(:provider).permit(:pname, :password, :password_confirmation, :email, :category, :business_id)
	end

end