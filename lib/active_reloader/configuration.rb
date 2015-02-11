module ActiveReloader
	class Configuration
		@@paths = ["app"]

		def self.paths
			@@paths.join(",")
		end

	end
end