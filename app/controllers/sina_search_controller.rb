#encoding : utf-8
require 'yaml/store'
class SinaSearchController < ApplicationController
  before_filter :client_info
 
  def weibo_search_index
    if user_signed_in?
      @userid = current_user.id
    else
      redirect_to :controller => 'home'
    end
  end
  
  #微博查询结果显示
  def weibo_search_display
     strq = params[:keyworld]
		   result = @client.search.suggestions_users(strq,{:count=>50})
#		   result |= @client.search.suggestions_apps(strq,{:count=>50})
#		   result |= @client.search.suggestions_companies(strq,{:count=>50})
#		   result |= @client.search.suggestions_schools(strq,{:count=>50})
#		   result |= @client.search.suggestions_at_users(strq, :type => 0)
#		   result |= @client.search.suggestions_at_users(strq, :type => 1)
		   @select_weibo_info = Array.new
		   result.each do |msg|
				   if msg.uid?
				     weibo = @client.users.show_by_uid(msg.uid)
				     comments_count = @client.comments.show(weibo.id).total_number
				     @select_weibo_info.push(weibo.merge({:comments_count=>comments_count}))
#				   elsif msg.screen_name?
#				     @select_weibo_info.push(@client.users.show_by_screen_name(msg.screen_name))
				   end
				 end

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def user_search_display
    if params[:strselect].present?
      @select_users_info = Array.new
				  userselect = @client.search.suggestions_users(params[:strselect],{:count => 50})
				  userselect.each do |user|
				    @select_users_info.push(@client.users.show_by_uid(user.uid))
				  end
				else
				
				end
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
    
  private
  
  #获取当前登录帐号的 微博user 信息
  def client_info
    if user_signed_in?
      userkey = Userkey.find(current_user.id)
    else
      userkey = Userkey.find(1)
    end
					@client = Sina::Client.new
     @client.get_token_from_hash({:access_token => userkey.key1, :expires_at => userkey.key2})
     @sina_user = YAML.load_file("config/sina_user.yml")
  end

end

