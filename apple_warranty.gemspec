# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "apple_warranty"
  gem.summary     = "Get Apple warranty info by device serial number"
  gem.description = "apple_warranty is a Ruby library with simple task in mind: get warranty info by Apple device serial number."
  gem.licenses    = ['MIT']
  gem.homepage    = "http://github.com/tmnsun/apple_warranty"
  gem.version     = '1.0.0'

  gem.authors     = ["Andrey Filippov"]
  gem.email       = "tmn.sun@gmail.com"

  gem.require_paths  = ["lib"]
  gem.files          = `git ls-files`.split("\n")
  gem.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.extra_rdoc_files = ["README.md"]
  gem.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "AppleWarranty"]
end
