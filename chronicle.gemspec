# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chronicle/version'

Gem::Specification.new do |spec|
  spec.name          = "chronicle"
  spec.version       = Chronicle::VERSION
  spec.authors       = ["Danielle Lancashire"]
  spec.email         = ["dani@builds.terrible.systems"]
  spec.summary       = %q{A simple way to generate a changelog.}
  spec.description   = %q{A simple way to generate a changelog.}
  spec.homepage      = "http://danie.lt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["chronicle"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  
  spec.add_runtime_dependency "git"
  spec.add_runtime_dependency "thor"
end
