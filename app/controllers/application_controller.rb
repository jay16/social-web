#encoding: utf-8
require 'yaml/store'
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from OAuth2::Error, :with => :deal_with_oauth2
  rescue_from SyntaxError, :with => :deal_with_syntax
  
 
  private
  
  def deal_with_syntax(exception)
    parse = "<h3>语法错误</h3>"
    exception.to_s.split("\n").each do |e|
      parse << "<div>" + e + "</div>"
    end
    parse << "<div style='float:right;'>" + Time.now.strftime("%m月%d日  %H:%M:%S").to_s + "</div>"
    
    render :inline => parse, :type => "html"
  end
  
  def deal_with_oauth2(exception)
    hash = convert_to_hash(exception)
    error_code = hash["error_code"].to_s
    
    case hash["error_code"]
    when '21327' then
      user = Userkey.find_by_user_id(current_user.id)
      if Time.at(user.key2.to_i) < Time.now
        render :partial => "home/firm_weibo", :locals => { :warn => "access_token过期！"} 
      end
    else 
      parse = "<h3>oauth2错误</h3>"
      parse << "<div>错误代号:    " + hash["error_code"].to_s + "</div>"
      parse << "<div>错误原因:    " + hash["error"] + "</div>"
      parse << "<div>错误代码:    " + hash["request"] + "</div>"
      parse << "<div>" + Time.now.strftime("%m月%d日  %H:%M:%S").to_s + "</div>"
      
      render :inline => parse, :type => "html"
    end
  end
  
		def convert_to_hash(exception)
		  puts exception
				hash = Hash.new
				hash["title"] = exception.code
				body = exception.to_s.match(/{(.*?)}/)[0].gsub(/({)|(})|(")/,"")
				tmp ||= body.split(",")
				tmp.each do |item|
				  hash["#{item.split(":")[0]}"] = item.split(":")[1]
				end
				hash
		end
end
