# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shenvy/version'

Gem::Specification.new do |spec|
  spec.name          = "shenvy"
  spec.version       = Shenvy::VERSION
  spec.authors       = ["Brian Murphy-Dye"]
  spec.email         = ["brian@murphydye.com"]

  spec.summary       = %q{Loads the environment created by a shell script into Ruby's ENV hash}
  spec.description   = %q{Useful for loading complex shell script environments (such as those composed when using
direnv) into RubyMine.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "coveralls"
end
