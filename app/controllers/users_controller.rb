class UsersController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
    User,
    params[:filterrific],
    select_options: {
        with_role_of: ["trainer", "inactive", "admin"]
      }
    ) or return

    @users = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
     puts "Had to reset filterrific params: #{ e.message }"
     redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.email = params[:user][:email]
    @user.address = params[:user][:address]
    @user.phone_number = params[:user][:phone_number]
    @user.role = params[:user][:role]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "#{@user.firstname} #{@user.lastname} Created!"
      redirect_to users_path
    else
      flash.now[:alert] = "There was an error creating the account. Please try again."
      redirect_back(fallback_location: dashboards_path)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end

    @user = User.find(params[:id])
    begin
      @user.update!(user_params)
      flash[:notice] = "User was updated."
      if current_user.admin?
        @user = User.find(current_user.id)
      end
      bypass_sign_in(@user)
      redirect_back(fallback_location: dashboards_path)
    rescue
      redirect_back(fallback_location: dashboards_path)
      flash[:alert] = "#{@user.errors.messages.first.map { |k,v| v }.join('').html_safe}."
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update(role: 'inactive')
      flash[:notice] = "#{@user.firstname} #{@user.lastname} was deleted succesfully."
      redirect_to users_path
    end
  end

  def metrics
    @user = current_user

    @pending_job_total_hours = FigureHours.call(@user.primary.where(job_completed: false).where(job_approved: false).group_by{ |j| j.job_date.to_date.month})
    @completed_job_total_hours = FigureHours.call(@user.primary.where(job_completed: true).where(job_approved: false).group_by{ |j| j.job_date.to_date.month})
    @accepted_job_total_hours = FigureHours.call(@user.primary.where(job_completed: true).where(job_approved: true).group_by{ |j| j.job_date.to_date.month})
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :phone_number, :email, :role, :address, :password, :password_confirmation)
  end
end
