class PagesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.



  def main
    @instagramName = params[:instagramName]
    if @instagramName != nil && @instagramName != ""
      @instagramURL = "https://api.instagram.com/v1/users/search?q=#{@instagramName}&client_id=b5cdd02ab8514f4a822fd3f28dd284b7"
      @instagramHash = RestClient.get @instagramURL
      @instagramID = JSON.parse(@instagramHash)['data'].map { |result| result['id'] }
      @myname = @instagramID[0].to_s
      begin
      @instagram = Instagram.user_recent_media(@myname, {:count => 10})
      rescue Instagram::BadRequest
      end
      puts @instagram
      return @instagram
      redirect_to("")
    end

    if(request.env['omniauth.auth'])
      @facebookuser = Facebookuser.koala(request.env['omniauth.auth']['credentials'])
      @feed = Feeds.koala(request.env['omniauth.auth']['credentials'])
      #redirect_to("back")
    end

  end

  def instagramHelper

  end



  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  #->Prelang (user_login:devise)
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in)        { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :twitterUsers) }
  end


  private
  
  #-> Prelang (user_login:devise)
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
    end
  end
end
