# encoding: utf-8
class FocusController < ApplicationController
  before_filter :focus_info
  
  def index
  end
  
  def weibo_create
    content = params[:focus_statuses_text]
    image = params[:pic]
    if image.present?
      timestamp = Time.now.strftime("%Y-%m-%d-%H-")
      timestamp << image.to_s.downcase
      img_path = File.join("public","upload",timestamp)
      @sina.statuses.upload(content, File.open(img_path))
      @qq.t.add_pic(content, img_path)
    else
      @sina.statuses.update(content)
      @qq.t.add(content)
    end
     
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def upload
    image = params[:focus_img_field]
    if image.present?
      timestamp = Time.now.strftime("%Y-%m-%d-%H-")
      timestamp << image.original_filename.to_s.downcase
      img_path =File.join("public","upload",timestamp)
      File.open(img_path, "wb") do |f| 
        f.write(image.read) 
      end
    end
    
    @img_path = File.join("","upload",timestamp)
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  #获取当前登录帐号的 微博user 信息
  def focus_info
    if user_signed_in?
      userkey = Userkey.find(current_user.id)
      
      if Time.at(userkey.key2.to_i) < Time.now
        redirect_to "/sina_weibo/connect"
      end
 
						@sina = Sina::Client.new
		    @sina.get_token_from_hash({:access_token => userkey.key1, :expires_at => userkey.key2})
      @sina_user = YAML.load_file("config/sina_user.yml")
    end
    
    opts = {:access_token => "a97b15eb32d82940c6ff8513311894fa",
            :openid => "78231A433C5FFBBFF3B164C10FBA0F9A",
            :clientip => "192.168.184.16"
            }
    @qq =  QQ::Client.new
    @qq.assign_params(opts)
  end
  
end
