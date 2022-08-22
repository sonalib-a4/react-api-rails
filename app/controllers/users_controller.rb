class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def login
    if params[:user][:email] && params[:user][:password]
      if params[:user][:email] == "sonali.barkund@afourtech.com" && params[:user][:password] == "Sonali@123"
        render json: params[:user][:username], status: :ok
      else
        render json: {error: 'Invalid user'}, status: :unprocessable_entity
      end
    else
      render json: 'params absent', status: :unprocessable_entity
    end
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :status, :email)
    end
end
