module ActiveReloader
	class Configuration

		@@paths = ["app"]

		def self.paths=(value)
			@@paths = value
		end

		def self.paths
			if @@paths.is_a?(String)
				@@paths = [@@paths]
			end
			@@paths
		end

		def self.update(&block)
			yield self
		end

	end
end