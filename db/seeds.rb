# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 
		def clear_tmp(file_path)
				if File.directory? file_path
				  Dir.foreach(file_path) do |file|
				    if file!="." and file!=".."
				      clear_tmp(file_path+"/"+file)
				    end
				  end
				else
				  if File.basename(file_path)[-1]=="~"
				    puts "Clear ~ file:"+ file_path.gsub("#{Rails.root}","")
				    File.delete(file_path)
				  end
				end
		end
		
		clear_tmp("#{Rails.root}")
