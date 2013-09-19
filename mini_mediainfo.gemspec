# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mini_mediainfo/version'

Gem::Specification.new do |spec|
  spec.name          = "mini_mediainfo"
  spec.version       = MiniMediainfo::VERSION
  spec.authors       = ["Karl Forsman"]
  spec.email         = ["ko.forsman@gmail.com"]
  spec.description   = %q{A Ruby wrapper for mediainfo CLI.}
  spec.summary       = %q{A minimalistic gem for wrapping mediainfo commands and parsing it's output.}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "thin"
  spec.add_development_dependency "sinatra"
end
