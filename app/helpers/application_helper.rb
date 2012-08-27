#encoding: utf-8
module ApplicationHelper
  
  def render_without_layout(t="")
	   respond_to do |format|
	     if t.present?
        format.html { render :template => "qq_weibo/#{t}", :layout => false }
      else
        format.html { render :layout => false }
      end
	   end
  end
  
end
