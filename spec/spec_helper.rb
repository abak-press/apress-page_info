# coding: utf-8

require 'bundler/setup'
require 'simplecov'

SimpleCov.start 'rails' do
  minimum_coverage 95
  add_filter "apress/page_info/version.rb"
end

require 'apress/page_info'
require 'pry-debugger'

require 'combustion'
Combustion.initialize! :action_controller do
  config.i18n.default_locale = :ru
  config.i18n.locale = :ru
end

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
end
