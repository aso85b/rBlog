class Admin::SessionsController < Admin::ApplicationController
   layout 'admin/login'
  def new
  end

  def create
    user = User.authentication(params[:email], params[:password])
    if user
      session[:user_id] = user_id
      redirect_to admin_posts_path, :notice => "Logged In"
    else
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, :notice => 'Logged Out'
  end
end
