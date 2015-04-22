# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

ENV['RACK_ENV'] ||= 'development'
$env = ENV['RACK_ENV']

Mongoid.load!("config/mongoid.yml", ENV['RACK_ENV'])

(Dir["./app/models/*.rb"].sort + Dir["./app/api/*.rb"]).each do |file|
  require file
end
