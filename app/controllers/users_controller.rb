class UsersController < ApplicationController
  #Before using
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles=@user.articles.paginate(page: params[:page], per_page:2)
  end

  def index
    #@users=User.all
    #Usage of will_paginate
    #@users=User.paginate(page: params[:page])

    #Usage with explicit 'per page ' limit
    @users=User.paginate(page: params[:page], per_page:2)


  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      flash[:notice]= "Welcome to Alperen Koksel #{@user.username}. You have been successfully signed up"
      #We want to sign users in once they sign up
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def destroy
    @user.destroy
    session[:user_id]= nil if @user==current_user
    flash[:notice]="Account and articles successfully deleted"
    redirect_to root_path
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert]="You can only edit your own username"
      redirect_to @user
    end
  end

end

# class UsersController < ApplicationController
#   before_action :set_user, only: [:show, :edit, :update, :destroy]
#
#   # GET /users
#   # GET /users.json
#   def index
#     @users = User.all
#   end
#
#   # GET /users/1
#   # GET /users/1.json
#   def show
#   end
#
#   # GET /users/new
#   def new
#     @user = User.new
#   end
#
#   # GET /users/1/edit
#   def edit
#   end
#
#   # POST /users
#   # POST /users.json
#   def create
#     @user = User.new(user_params)
#
#     respond_to do |format|
#       if @user.save
#         format.html { redirect_to @user, notice: 'User was successfully created.' }
#         format.json { render :show, status: :created, location: @user }
#       else
#         format.html { render :new }
#         format.json { render json: @user.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /users/1
#   # PATCH/PUT /users/1.json
#   def update
#     respond_to do |format|
#       if @user.update(user_params)
#         format.html { redirect_to @user, notice: 'User was successfully updated.' }
#         format.json { render :show, status: :ok, location: @user }
#       else
#         format.html { render :edit }
#         format.json { render json: @user.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /users/1
#   # DELETE /users/1.json
#   def destroy
#     @user.destroy
#     respond_to do |format|
#       format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_user
#       @user = User.find(params[:id])
#     end
#
#     # Only allow a list of trusted parameters through.
#     def user_params
#       params.require(:user).permit(:username)
#     end
# end
