module ActiveReloader
	class Railtie < Rails::Railtie
		initializer "active_reloader.configuration" do |app|
			FileUtils.rm_rf("#{Rails.application.root}/tmp/cache/assets") if Rails.env.development?
		end
	end
end