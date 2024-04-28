# frozen_string_literal: true

require_relative "lib/xrb/rails/version"

Gem::Specification.new do |spec|
	spec.name = "xrb-rails"
	spec.version = XRB::Rails::VERSION
	
	spec.summary = "Add support XRB templates in Rails."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/xrb-rails"
	
	spec.metadata = {
		"documentation_uri" => "https://socketry.github.io/xrb-rails/",
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"source_code_uri" => "https://github.com/ioquatix/xrb-rails.git",
	}
	
	spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 3.1"
	
	spec.add_dependency "xrb", "~> 0.3"
end
