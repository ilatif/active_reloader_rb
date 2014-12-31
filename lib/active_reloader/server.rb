module ActiveReloader
	class Server
		def self.start
			builder = Rack::Builder.new do
				map '/' do
					html_response = File.read(File.expand_path("../../../app/html/iframe.html", __FILE__))
					run Proc.new { [200, {"Content-Type" => "text/html"}, [html_response]] }
				end

				map '/javascripts/active_reloader_main.js' do 
					js_code = File.read(File.expand_path("../../../app/assets/javascripts/active_reloader_main.js", __FILE__))
					run Proc.new { [200, {"Content-Type" => "text/javascript"}, [js_code]] }
				end
			end
			builder
		end
	end
end