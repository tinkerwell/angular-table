# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular-table/version'

Gem::Specification.new do |spec|
  spec.name          = "angular-table"
  spec.version       = AngularTable::VERSION
  spec.authors       = ["Samuel Mueller"]
  spec.email         = ["mueller.samu@gmail.com"]
  spec.description   = %q{angular-table}
  spec.summary       = %q{angular-table}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + Dir["vendor/**/*"] + ["../README.md", "../LICENSE.txt"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
