#encoding: utf-8
require 'yaml/store'
class SinaWeiboController < ApplicationController
  before_filter :sina_info, :except => [:connect, :callback, :logout]
  
  #获取当前登录用户及其所关注用户的最新微博   
  def index
		  @user_info = @client.users.show_by_uid("2712105793")
		  @sina_face = YAML.load_file("config/sina_face.yml")
		  
		  File.delete("config/sina_user.yml") if File.exists?("config/sina_user.yml")
		  sina_user = YAML::Store.new("config/sina_user.yml")
		  sina_user.transaction do
						sina_user["user"] = @user_info.to_hash
				end
				
				
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def statuses_search
     @is_user = false
     @result = case params[:style]
     when "微博" then @client.search.suggestions_statuses(params[:keyworld],{:count=>50})
     when "用户" then @client.search.suggestions_users(params[:keyworld],{:count=>50})
     when "学校" then @client.search.suggestions_schools(params[:keyworld],{:count=>50})
     when "公司" then @client.search.suggestions_companies(params[:keyworld],{:count=>50})
     when "应用" then @client.search.suggestions_apps(params[:keyworld],{:count=>50})
     when "@联想" then @client.search.suggestions_at_users(params[:keyworld],1,{:count=>50})
     else @client.search.suggestions_statuses(params[:keyworld],{:count=>50})
     end
     
     if params[:style] == "用户"
						 @select_weibo_info = Array.new
						 @result.each do |msg|
						     puts msg.screen_name
								   weibo = @client.users.show_by_screen_name(msg.screen_name)
								   @select_weibo_info.push(weibo)
							end
					  @result = @select_weibo_info
					  @is_user = true
					end
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
		end
  #@我的微博
  def statuses_mentions
    @statuses_mentions = @client.statuses.mentions
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
  
  #@我的评论
  def comments_mentions
    @statuses_mentions = @client.comments.mentions
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
  
  #发表微博 #url上传图片需要高权限
  def statuses_update
    content = params[:sina_statuses_text]
    extension = File.extname(params[:pic]).underscore
    if params[:pic].present?
      img_path = File.join("public","upload_img#{extension}")
      @statuse = @client.statuses.upload(content, File.open(img_path))
    else
      @statuse = @client.statuses.update(content)
    end
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
  
  def upload
    image = params[:sina_img_field]
    if image.present?
      timestamp = Time.now.strftime("%Y-%m-%d-%H-")
      timestamp << image.original_filename.to_s.downcase  
      img_path = Rails.root.join("public","upload",timestamp)
      File.open(img_path, "wb") do |f| 
        f.write(image.read) 
      end
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  #用户信息下载到本地
  def statuses_download
					send_data(params[:content],
							:type => "text/html; charset=utf-8; header=present",
							:disposition => "attachment",
							:filename => "userinfo_#{Time.now.strftime("%Y%m%d%H%M%S")}.html")
  end
  
  #我发出的评论
  def comments_by_me
    @comments_by_me = @client.comments.by_me
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
  
  #我收到的评论
  def comments_to_me
    @comments_to_me = @client.comments.to_me
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
 
  #我的粉丝
  def followers
    @followers = hashie @client.friendships.followers({:uid => 2712105793})
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  
  end

  #我的关注
  def friends
    @friends = hashie @client.friendships.friends({:uid => 2712105793})
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
  
  #我的收藏
  def favorites
    @favorites = @client.favorites.favorites
    
	   respond_to do |format|
      format.html { render :layout => false }
	   end
  end
  
  #回复评论
  def answer
    if user_signed_in?
      @userid = current_user.id
    else
      #@userid = 1
      redirect_to :controller => 'home'
    end
  end
  
   # 微博转发
  def repost
    if params[:user_id].present?
      #同时评论原微博
      if (params[:is_comment] == "checked" or params[:is_comment] == true) and params[:comment].present?
        @after_repost = @client.statuses.repost(params[:user_id].to_i, {:comment_ori => 1,:comment => params[:comment]})
      else
        @after_repost = @client.statuses.repost(params[:user_id].to_i)
      end
    else
    end
    
    respond_to do |format|
      format.html { render :layout => false } #:layout => false 设置不使用页面框架
    end
  end
  
  # 微博评论
  def comments_create
    if params[:comment].present? and params[:wbid].present?
      #同时评论原微博
      if params[:is_repost] == "checked" or params[:is_repost] == true
         @comment = @client.comments.create(params[:comment],params[:wbid].to_i,{ :comment_ori => 1 })
      else
         @comment = @client.comments.create(params[:comment],params[:wbid].to_i)
      end
    else
    end
   
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  #获取评论列表
  def comments_list
    @comments_list = @client.comments.show(params[:weibo_id])
    @span = params[:is_reweeted] == "true" ? 3 : 4
#    require 'yaml/store'
#		  store = YAML::Store.new "comments_list.yaml"
#		  puts store
#		  store.transaction do
#						store["comments_list"] =  @comments_list.to_hash
#				end
#    
    respond_to do |format|
      format.html { render :layout => false }
    end
    
  end
  
  #添加关注
  def friendship_create
    @friendship_create = @client.friendships.create({:uid => params[:user_id]})
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  #删除关注
  def friendship_destroy
    @friendship_destroy = @client.friendships.destroy({:uid => params[:user_id]})
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
   
  #获取最新的公共微博 
  def public_timeline
		  @statuses_timeline = @client.statuses.public_timeline()
		  
		  respond_to do |format|
		    if params[:focus_index] == "yes"
       format.html { render :template => "home/sina_public_timeline", :layout => false }
      else
       format.html { render :template => "sina_weibo/statuses_template", :layout => false }
      end
    end
  end
   
  #获取最新的公共微博 
  def friends_timeline
		  @statuses_timeline = @client.statuses.friends_timeline()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #获取当前登录用户及其所关注用户的最新微博 
  def home_timeline
		  @statuses_timeline = @client.statuses.home_timeline()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #获取用户发布的微博 
  def user_timeline
		  @statuses_timeline = @client.statuses.user_timeline()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #获取双向关注用户的最新微博 
  def bilateral_timeline
		  @statuses_timeline = @client.statuses.bilateral_timeline()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #返回用户转发的最新微博
  def repost_by_me
		  @repost_by_me = @client.statuses.repost_by_me()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #按天返回热门转发榜 
  def hot_repost_daily
		  @hot_repost_daily = @client.statuses.hot_repost_daily()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #按周返回热门转发榜 
  def hot_repost_weekly
		  @hot_repost_weekly = @client.statuses.hot_repost_weekly()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #按天返回当前用户关注人的热门微博评论榜 
  def hot_comments_daily
		  @hot_comments_daily = @client.statuses.hot_comments_daily()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
   
  #按周返回热门评论榜 
  def hot_comments_weekly
		  @hot_comments_weekly = @client.statuses.hot_comments_weekly()
		  
		  respond_to do |format|
      format.html { render :template => "sina_weibo/statuses_template", :layout => false }
    end
  end
  
  def connect
    redirect_to Sina::Client.new.authorize_url
  end
  
  def callback
    if user_signed_in?
				access_hash = Sina::Client.new.get_access_token(params[:code])
				session[:uid], session[:access_token], session[:expires_at] = access_hash.uid, access_hash.access_token, access_hash.expires_at
				puts access_hash
				puts access_hash.uid
     save_user_key(current_user.id, current_user.email, "sinaweibo", access_hash.access_token, access_hash.expires_at, access_hash.uid)
    end
    redirect_to "/focus/index"
  end
  
  #前登录用户退出
  def logout
    session[:atoken], session[:asecret] = nil, nil
    redirect_to "/"
  end

  private
  
  #获取当前登录帐号的 微博user 信息
  def sina_info
    if user_signed_in?
      userkey = Userkey.find(current_user.id)
      
      if Time.at(userkey.key2.to_i) < Time.now
        redirect_to "/sina_weibo/connect"
      end
 
						@client = Sina::Client.new
		    @client.get_token_from_hash({:access_token => userkey.key1, :expires_at => userkey.key2})
      @sina_user = YAML.load_file("config/sina_user.yml")
    end
  end
  
  def encode(value, encoding = "utf-8")  
    String === value ? value.force_encoding(encoding) : value  
  end  
  
  #保存当前登录帐号的access_token信息
  def save_user_key(intuserid,strusermail,strwbfirm,access_token,expires_at,uid)
    count = Userkey.count_by_sql("select count(*) from userkeys where user_id='#{current_user.id}' and weibo_firm='sinaweibo'")
    if count == 0 then
					 Userkey.create(
					  :user_id => intuserid, 
					  :mail_user => strusermail, 
					  :weibo_firm => strwbfirm, 
					  :key1 => access_token, 
					  :key2 => expires_at,
					  :UID => uid
					 )
    else
      Userkey.find_by_user_id("#{current_user.id}".to_i).update_attributes(
       :user_id => intuserid, 
					  :mail_user => strusermail, 
					  :weibo_firm => strwbfirm, 
					  :key1 => access_token, 
					  :key2 => expires_at,
					  :UID => uid
					  )
    end
  end
  
  def hashie(response)
    json_body = JSON.parse(response.body)
    if json_body.is_a? Array
      Array.new(json_body.count){|i| Hashie::Mash.new(json_body[i])}
    else
      Hashie::Mash.new json_body
    end
  end
end
