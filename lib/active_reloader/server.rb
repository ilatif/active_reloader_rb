require "active_reloader/file_system"
module ActiveReloader
	class Server
		def self.start
			builder = Rack::Builder.new do
				map '/' do
					html_response = File.read(File.expand_path("../../../app/html/iframe.html", __FILE__))
					run Proc.new { [200, {"Content-Type" => "text/html"}, [html_response]] }
				end

				map '/check_for_changes' do
					run Proc.new { |env|
						req = Rack::Request.new(env)
						json = ActiveReloader::FileSystem.new(req).notify
						[200, {"Content-Type" => "application/json"}, json]
					}
				end

				map '/javascripts/jquery-1.11.2.js' do
					js_code = File.read(File.expand_path("../../../app/assets/javascripts/jquery-1.11.2.js", __FILE__))
					run Proc.new { [200, {"Content-Type" => "text/javascript"}, [js_code]] }
				end

				map '/javascripts/active_reloader_main.js' do 
					js_code = File.read(File.expand_path("../../../app/assets/javascripts/active_reloader_main.js", __FILE__))
					run Proc.new { [200, {"Content-Type" => "text/javascript"}, [js_code]] }
				end
			end
		end

		def self.port=(value)
			@@port = value
		end

		def self.port
			@@port
		end

		def self.url
			"http://localhost:#{@@port}"
		end
	end
end