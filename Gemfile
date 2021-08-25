# frozen_string_literal: true
source 'https://rubygems.org'

gem 'activesupport', '~> 4.0.0', require: false
gem 'test-unit'

gemspec

if RUBY_VERSION < '2.3'
  gem 'pry-byebug', '< 3.7.0', require: false
end

# NameError: uninitialized constant Pry::Command::ExitAll при попытке выполнить require 'pry-byebug'
gem 'pry', '< 0.13.0', require: false
gem 'rspec-rails', '>= 3.3', '<= 3.9', require: false
