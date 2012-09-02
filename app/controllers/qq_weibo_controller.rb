#encoding : utf-8
class QqWeiboController < ApplicationController
  include ApplicationHelper
  before_filter :qq_user, :except => [:connect, :callback, :logout]
  
  def index
    @user_info = @qq.user.info
    
    respond_to do |format|
      format.html# { render :layout => false }
    end
  end
  #发布微博
  def t_add
    content = params[:qq_statuses_text]
    image = params[:pic]
    if image.present?
      timestamp = Time.now.strftime("%Y-%m-%d-%H-")
      timestamp << image.to_s.downcase
      img_path = File.join("public","upload",timestamp)
      @qq.t.add_pic(content,img_path)
    else
      @qq.t.add(content)
    end
     
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def upload
    image = params[:qq_img_field]
    if image.present?
      timestamp = Time.now.strftime("%Y-%m-%d-%H-")
      timestamp << image.original_filename.to_s.downcase
      img_path =File.join("public","upload",timestamp)
      File.open(img_path, "wb") do |f| 
        f.write(image.read) 
      end
    end
    
    respond_to do |format|
      format.js
    end
  end
  # 主页时间线
  def home_timeline
    @statuses = @qq.statuses.home_timeline
    
    render_without_layout("home_timeline")
  end
  #广播大厅时间线
  def public_timeline
    @statuses = @qq.statuses.public_timeline
    if params[:focus_index] == "yes"
				  respond_to do |format|
				    format.html { render :template => "home/qq_public_timeline", :layout => false }
				  end
    else
     render_without_layout("home_timeline")
    end
  end
  #其他用户发表时间线
  def user_timeline
    @statuses = @qq.statuses.user_timeline
    
    render_without_layout("home_timeline")
  end
  #我发表时间线
  def broadcast_timeline
    @statuses = @qq.statuses.broadcast_timeline
    
    render_without_layout("home_timeline")
  end
  #特别收听的人发表时间线
  def special_timeline
    @statuses = @qq.statuses.special_timeline
    
    render_without_layout("home_timeline")
  end
  #用户提及时间线
  def mentions_timeline
    @statuses = @qq.statuses.mentions_timeline
    
    render_without_layout("home_timeline")
  end
  #我的听众列表，只输出name
  def fanslist
    @statuses = @qq.friends.fanslist
    
    render_without_layout("fanslist")
  end
  #我收听的人列表，只输出name
  def idollist
    @statuses = @qq.friends.idollist
    
    render_without_layout("fanslist")
  end
  #人物搜索
  def search_user
    @statuses = @qq.search.user(params[:value])
    
    render_without_layout("search")
  end
  #微博搜索
  def search_t
    @statuses = @qq.search.t(params[:value])
    
    render_without_layout("search_t")
  end
  #话题搜索
  def search_ht
    @statuses = @qq.search.ht(params[:value])
    
    render_without_layout("search_ht")
  end
  
		def callback				
				if user_signed_in?
				 access_hash = QQ::Client.new.get_access_token(params[:code])	
				 puts access_hash
				 puts params[:openid]
					save_user_key(current_user.id, access_hash.refresh_token, "qqweibo", access_hash.access_token, access_hash.expires_at, params[:openid])
				end
				
				redirect_to "/focus/index"
  end

  def connect
    redirect_to QQ::Client.new.authorize_url
  end
  
  def save_user_key(intuserid,refresh_token,strwbfirm,access_token,expires_at,uid)
    count = Userkey.count_by_sql("select count(*) from userkeys where user_id='#{current_user.id}' and weibo_firm='qqweibo'")
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
      Userkey.find_by_sql("select * from userkeys where user_id='#{current_user.id}' and weibo_firm='qqweibo'").first.update_attributes(
       :user_id => intuserid, 
					  :mail_user => refresh_token, 
					  :weibo_firm => strwbfirm, 
					  :key1 => access_token, 
					  :key2 => expires_at,
					  :UID => uid
					  )
    end
  end
  
  def qq_user
#    opts = {:access_token => "a97b15eb32d82940c6ff8513311894fa",
#            :openid => "78231A433C5FFBBFF3B164C10FBA0F9A",
#            :clientip => "192.168.184.16"
#            }
#   
#						@qq = QQ::Client.new
#						@qq.assign_params(opts)
		  if user_signed_in?
		    qq_user = Userkey.find_by_sql("select * from userkeys where user_id='#{current_user.id}' and weibo_firm='qqweibo'").first
		    access_token = qq_user.key1
		    expires_at = qq_user.key2
      puts access_token
      puts expires_at
      puts qq_user.to_s
		    opts = {:access_token => access_token,
            :openid => "78231A433C5FFBBFF3B164C10FBA0F9A",
            :clientip => "192.168.184.16"
            }
						@qq = QQ::Client.new
						@qq.assign_params(opts)
		  else
		    redirect_to "/home/about"
		  end
		  
  end

end
