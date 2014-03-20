# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'box_view/version'

Gem::Specification.new do |spec|
  spec.name          = "box_view"
  spec.version       = BoxView::VERSION
  spec.authors       = ["Reilly Forshaw"]
  spec.email         = ["reilly.forshaw@goclio.com"]
  spec.description   = "API client for Box View"
  spec.summary       = "A ruby library to interact with Box View"
  spec.homepage      = "https://github.com/reillyforshaw/box_view"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
