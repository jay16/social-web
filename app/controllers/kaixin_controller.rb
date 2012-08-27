class KaixinController < ApplicationController
require "faraday"
  def index
    url1 = "https://api.kaixin001.com/users/me.json?access_token=146226728_81f97c3f276236ff069a62f447720646"
    url = "https://api.weibo.com/2/statuses/public_timeline.json?access_token=2.00pbiXxC7oSwrBe64f5385f8JVRq4D"
     render :text => Faraday.get(url).body
    #redirect_to url
  end
  
  def connect
    redirect_to Kaixin::Client.new.authorize_url
  end
  
  def callback
    if params[:code]
    url = "https://api.kaixin001.com/oauth2/access_token?
grant_type=authorization_code&
code=#{params[:code]}&
client_id=#{Kaixin::Config.api_key}&
client_secret=#{Kaixin::Config.api_secret}&
redirect_uri=#{Kaixin::Config.redirect_uri}"
    render :text => Faraday.get(url).body
    end
#    {"access_token":"146226728_81f97c3f276236ff069a62f447720646",
#    "expires_in":2592000,
#    "scope":"basic",
#    "refresh_token":"146226728_25b9c1922b43346ef640b339314d97cb"}
  end
  
end
