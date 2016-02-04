# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/omniauth-carvoyant/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-carvoyant'
  spec.version       = OmniAuth::Carvoyant::VERSION
  spec.authors       = ['Farrukh Abdulkadyrov']
  spec.email         = ['farrukhabdul@gmail.com']

  spec.summary       = 'Carvoyant OAuth2 strategy for OmniAuth'
  spec.homepage      = 'https://github.com/faragorn/omniauth-carvoyant'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
end
