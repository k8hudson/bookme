class UsersController < ApplicationController

  before_action :check_user_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render action: :new
    end
  end

  def show
    @user = User.find(params[:id])
    
  end
  #
  def events
    @events = Event.where(user_id: params[:id])

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
    @current_user.update_attributes(user_params)
    redirect_to user_path(@current_user)
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :handle, :avatar, :remove_avatar, :password, :password_confirmation)
  end
end