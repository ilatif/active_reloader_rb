require "active_reloader/version"
require "active_reloader/server"
require "active_reloader/railtie"
require "active_reloader/engine"
require "active_reloader/configuration"

module ActiveReloader
end

# Code to run active_reloader server
if (defined?(Rails::Server) && Rails.env.development?)
	Thread.new do 
		server_script_path = File.expand_path("../../config.ru", __FILE__)
		port = Rails::Server.new.options[:Port] + 1
		ActiveReloader::Server.port = port
		`rackup '#{server_script_path}' -p #{port} -E none`
	end
	File.write(File.expand_path("../../app/assets/javascripts/active_reloader.js", __FILE__), "//= require active_reloader_initializer");
else
	File.write(File.expand_path("../../app/assets/javascripts/active_reloader.js", __FILE__), "");
end