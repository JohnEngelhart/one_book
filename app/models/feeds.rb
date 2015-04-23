class Feeds < ActiveRecord::Base

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    @feed = facebook.get_connections("me","feed")
  end
end
