# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'rails/all'

require 'rspec/rails'
#require "/Users/elia.gilad/work/boost_rules/spec/../lib/boost_rules/assets_provider.rb"

require './app/controllers/api/v1/resources/context_logger_controller.rb'
#Dir[File.dirname(__FILE__) + "/../**/*.rb"].each {|file| require file }

require 'spec_helper'

RSpec.configure do |config|

end
