# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "squatch/version"

Gem::Specification.new do |s|
  s.name        = "squatch"
  s.version     = Squatch::VERSION
  s.authors     = ["Domino"]
  s.email       = ["domino.steve@gmail.com"]
  s.homepage    = "http://github.com/sdomino/squatch"
  s.summary     = "It's going to relate to sass, and I think I know what I want it to do..."
  s.description = "It's going to relate to sass, and I think I know what I want it to do..."

  s.rubyforge_project = "squatch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_development_dependency 'rspec'
end
