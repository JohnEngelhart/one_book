class InstagramController < ApplicationController
  def page
    @instagram = Instagram.user_recent_media("209486129", {:count => 10})
  end
end
