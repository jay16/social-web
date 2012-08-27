#encoding : utf-8
require 'yaml'
class HomeController < ApplicationController

  def about
    @sina_face = YAML.load_file("config/sina_face.yml")
  end
  
  def index
    if user_signed_in?
      @number = Userkey.count_by_sql("select count(*) from userkeys where user_id='#{current_user.id}' and mail_user='#{current_user.email}'")
      if @number == 0
        render "/home/index"
      end
    else
    end
  end
  
  def userinfo
    if user_signed_in?
      @struserinfo = UserInfo.find_by_user_id(current_user.id)
    else
      @struserinfo = UserInfo.find_by_user_id(1)
    end
  end

end
