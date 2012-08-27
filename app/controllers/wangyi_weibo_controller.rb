class WangyiWeiboController < ApplicationController
  before_filter :wangyi_user, :except => [:connect, :callback, :logout]
  
  def index
    @user = @wangyi.users.show
  end
  
  def public_timeline
    @statuses = @wangyi.statuses.public_timeline
  end
  
  def home_timeline
    @statuses = @wangyi.statuses.home_timeline
    
	   respond_to do |format|
      format.html  {render :layout => false}
	   end
  end
  
  def connect
    redirect_to Wangyi::Client.new.authorize_url
  end
  
  def callback
    access_hash = Wangyi::Client.new.get_access_token(params[:code].to_s)
    if user_signed_in?
      save_user_key(current_user.id,access_hash.refresh_token,"wangyiweibo",access_hash.access_token,
        access_hash.expires_at,access_hash.uid)
    end
    
    redirect_to "/wangyi_weibo/index"
  end
  
  def logout
  end
  
		def wangyi_user
		  if user_signed_in?
		    wangyi_user = Userkey.find_by_sql("select * from userkeys where user_id='#{current_user.id}' and weibo_firm='wangyiweibo'").first
		    access_token = wangyi_user.key1
		    expires_at = wangyi_user.key2
		    #刷新access_token
		    if Time.at(expires_at.to_i) < Time.now
		      access_hash = Wangyi::Client.new.refresh_token(wangyi_user.mail_user)
		      save_user_key(current_user.id,access_hash.refresh_token,"wangyiweibo",access_hash.access_token,
          access_hash.expires_at,access_hash.uid)
        access_token = access_hash.access_token
		    end
		     
						@wangyi = Wangyi::Client.new
						@wangyi.assign_params({"access_token" => access_token})
		  else
		    redirect_to "/home/about"
		  end
				
  end
  
  def save_user_key(intuserid,refresh_token,strwbfirm,access_token,expires_at,uid)
    count = Userkey.count_by_sql("select count(*) from userkeys where user_id='#{current_user.id}' and weibo_firm='wangyiweibo'")
    if count == 0 then
					 Userkey.create(
					  :user_id => intuserid, 
					  :mail_user => refresh_token, 
					  :weibo_firm => strwbfirm, 
					  :key1 => access_token, 
					  :key2 => expires_at,
					  :UID => uid
					 )
    else
      Userkey.find_by_sql("select * from userkeys where user_id='#{current_user.id}' and weibo_firm='wangyiweibo'").first.update_attributes(
       :user_id => intuserid, 
					  :mail_user => refresh_token, 
					  :weibo_firm => strwbfirm, 
					  :key1 => access_token, 
					  :key2 => expires_at,
					  :UID => uid
					  )
    end
  end
end
