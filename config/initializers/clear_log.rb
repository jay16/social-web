		if Rails.env.development?
					LOG_SIZE_LIMIT = 1024*1024

					logs = [File.join(Rails.root, 'log', 'development.log'), 
												 File.join(Rails.root, 'log', 'product.log'),
												 File.join(Rails.root, 'log', 'test.log')]
												 
					logs.each do |log|
							if File.exists?(log) and File.size(log) > LOG_SIZE_LIMIT
									File.open(log,"w+") do |file|
									  file.puts "#{Time.now}:clear log!"
									       puts "#{Time.now}:clear log!"
									end
							end
					end
		end
  
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
