# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_reloader/version'

Gem::Specification.new do |spec|
  spec.name          = "active_reloader"
  spec.version       = ActiveReloader::VERSION
  spec.authors       = ["Imran Latif"]
  spec.email         = ["ilatif.bwp@gmail.com"]
  spec.summary       = %q{A Rails gem that reloads browser as soon as you do some changes in your Rails app.}
  spec.description   = %q{A Rails gem that reloads browser as soon as you do some changes in your Rails app. We as web developers are sometimes bounded in Change -> Switch to Browser -> Refresh -> Change cycle. This really hurts productivity. This gem will help you in breaking this cumbersome routine and your browser will be refreshed automatically whenever it detects any change in Rails code thus freeing you from that manually updating browser and hence resulting in increased productivity.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
