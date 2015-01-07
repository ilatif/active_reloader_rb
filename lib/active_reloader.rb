require "active_reloader/version"
require "active_reloader/server"

module ActiveReloader
  # Your code goes here...
end

# Code to run active_reloader server
if (defined?(Rails::Server))
	Thread.new do 
		server_script_path = File.expand_path("../../config.ru", __FILE__)
		port = Rails::Server.new.options[:Port] + 1
		puts "\n\n\n\n\n\n =========#{server_script_path}\n\n\n\n"
		`rackup '#{server_script_path}' -p #{port}`
	end
end