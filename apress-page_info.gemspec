# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apress/page_info/version'

Gem::Specification.new do |spec|
  spec.name          = 'apress-page_info'
  spec.version       = Apress::PageInfo::VERSION
  spec.authors       = ['Merkushin']
  spec.email         = ['merkushin.m.s@gmail.com']
  spec.summary       = %q{apress-page_info}
  spec.description   = %q{apress-page_info}
  spec.homepage      = 'https://github.com/abak-press/apress-page_info'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 3.2', '< 5.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'appraisal', '>= 1.0.2'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'tzinfo'
  spec.add_development_dependency 'actionpack', '>= 3.2', '< 5.0'
end
