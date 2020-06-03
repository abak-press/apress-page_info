# coding: utf-8
# frozen_string_literal: true
# load everything from tasks/ directory
Dir[File.join(File.dirname(__FILE__), 'tasks', '*.{rb,rake}')].each { |f| load(f) }

require 'rspec/core/rake_task'

# setup `spec` task
RSpec::Core::RakeTask.new(:spec)