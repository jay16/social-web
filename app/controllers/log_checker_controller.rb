#encoding: utf-8
class LogCheckerController < ApplicationController

  def index
    @file_path = "#{Rails.root}/log"
    @file_array = Array.new
				if File.directory? @file_path
				  Dir.foreach(@file_path) do |file|
				    @file_array.push(file) if file!="." and file!=".." and File.extname(file) == ".log"
				  end
				else
				  puts "It's File Not Directory"
				end
    
    respond_to do |format|
      format.html { render :layout => false}
    end
  end
  
  def log_loader
    @content = Array.new
		  File.open(File.join(Rails.root, 'log', params[:file_path]),"r") do |file|
						file.each_line do |line|
						@content.push(line)
						end
    end
    @content = @content.reverse
    
    respond_to do |format|
      format.html { render :layout => false}
    end
  end
  
end
