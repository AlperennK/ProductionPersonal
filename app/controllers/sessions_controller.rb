class SessionsController < ApplicationController

  def new

  end


  #Difference between flash.now and flash[:notice] is [:notice] perssists through html page. flash.now will disappear once user passes wrong arguements
  def create
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash[:notice]="Logged in successfully"
      redirect_to user

    else
      flash.now[:alert]="There was something wrong with your login details"
      render 'new'
    end

  end

  def destroy
    session[:user_id]=nil
    flash[:notice]="Logged out"
    redirect_to root_path
  end



end