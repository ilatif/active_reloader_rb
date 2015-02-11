require 'json'
require 'find'
require 'time'
module ActiveReloader
	class FileSystem
		def initialize(request)
			@request = request
		end

		def notify
			_notify
		end

		private

		def _notify
			response = {"status" => 0}

			rails_root = @request.params["rails_root"]
			paths      = @request.params["paths"]
			application_folder = "#{rails_root}/#{paths}"

			file_paths = []
			change_found = false

			# Time.now.to_i gives us time in UTC
			start_time = Time.now.to_i
			end_time   = start_time + 25

			Find.find(application_folder) do |path|
				if (FileTest.file?(path) && File.basename(path)[0] != ".")
					# File.mtime gives us time in local time zone. We will convert it to UTC using to_i method on Time
					file_mtime = Time.parse(File.mtime(path).to_s).to_i
					if (file_mtime > start_time)
						change_found = true
						break
					end
					file_paths << path
				end
			end

			while(Time.now.to_i < end_time && change_found == false) 
				file_paths.each do |path|
					file_mtime = Time.parse(File.mtime(path).to_s).to_i
					if (file_mtime > start_time)
						change_found = true
						break
					end
				end
			end

			if (change_found)
				response["status"] = 1
			end

			[response.to_json]

		end

	end
end