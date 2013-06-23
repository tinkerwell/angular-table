# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular-table/version'

Gem::Specification.new do |spec|
  spec.name          = "angular-table"
  spec.version       = AngularTable::VERSION
  spec.authors       = ["Samuel Mueller"]
  spec.email         = ["mueller.samu@gmail.com"]
  spec.description   = "Angular directive for easy HTML table declaration. Makes them sortable and adds pagination."
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/ssmm/angular-table"
  spec.license       = "MIT"
  spec.files         = Dir["lib/**/*"] + Dir["app/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
