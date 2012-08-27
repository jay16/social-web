# encoding: utf-8
class FocusController < ApplicationController
  #before_filter :focus_info
  CRLF = "\r\n"
  def index
  end
  
  def upload
    img_path = Rails.root.join("public","images","bbs_bg.jpg")
#        url = "https://open.t.qq.com/api/t/add"
#        opts = {:access_token => "a97b15eb32d82940c6ff8513311894fa",
#            :openid => "78231A433C5FFBBFF3B164C10FBA0F9A",
#            :clientip => "192.168.184.16",
#            :content => "img to qq from local",
#            }
#        opts.merge!({:format => "json",
#                       :oauth_consumer_key => "#{QQ::Config.api_key}",
#                       :content_type => 'application/www-form-urlencoded',
#                       :oauth_version => "2.a", 
#                       :scope => "all"})
# 
#        
#        boundary = Time.now.to_i.to_s(16)
#        body = ""
#        opts.each do |key, value|
#          esc_key = CGI.escape(key.to_s)
#          body << "--#{boundary}#{CRLF}"
#          if value.respond_to?(:read)
#            body << "Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{File.basename(value.path)}\"#{CRLF}"
#            body << "Content-Type: image/jpg#{CRLF*2}"
#            body << value.read
#          else
#            body << "Content-Disposition: form-data; name=\"#{esc_key}\"; #{CRLF*2}#{value}"
#          end
#          body << CRLF
#        end
#        
#        body << "--#{boundary}--#{CRLF*2}"
#        puts body
#        para={
#        :body => body,
#        :headers => {"Content-Type" => "multipart/form-data; boundary=#{boundary}"}
#        }
#conn = Faraday.new(:url => 'https://open.t.qq.com')  
#conn = Faraday.new(:url => 'https://open.t.qq.com') do |f|  
#    f.request :multipart  
#    f.adapter :net_http  
#  end       
#  opts = {:content => "img to qafdq from losdfcalasdf", :pic => Faraday::UploadIO.new("public/images/bbs_bg.jpg", 'image/jpeg'),:content_type => 'application/www-form-urlencoded',:access_token => "a97b15eb32d82940c6ff8513311894fa",:openid => "78231A433C5FFBBFF3B164C10FBA0F9A",:clientip => "192.168.184.16",:oauth_consumer_key => QQ::Config.api_key,:oauth_version => "2.a",:scope => "all"}
#  conn.post('/api/t/add_pic',opts)
  
  		   opts = {:access_token => "a97b15eb32d82940c6ff8513311894fa",
            :openid => "78231A433C5FFBBFF3B164C10FBA0F9A",
            :clientip => "192.168.184.16"
            }
						@qq = QQ::Client.new
						@qq.assign_params(opts)
						@res = @qq.t.add_pic("qq api",img_path)
#conn = Faraday.new(:url => 'https://open.t.qq.com')  
#  conn.post '/api/t/add', :content => "hello", :syncflag => 1, :access_token => "a97b15eb32d82940c6ff8513311894fa",:openid => "78231A433C5FFBBFF3B164C10FBA0F9A",:clientip => "192.168.184.16",:oauth_consumer_key => QQ::Config.api_key,:oauth_version => "2.a",:scope => "all"
  render :inline => "hello"
  end
  
  def statuses_create
    content = params[:focus_statuses_text]
    @statuse = @client.statuses.update(content)
    @qq.t.add(content)
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
 
						@client = Sina::Client.new
		    @client.get_token_from_hash({:access_token => userkey.key1, :expires_at => userkey.key2})
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
