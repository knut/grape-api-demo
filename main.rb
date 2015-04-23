# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

ENV['RACK_ENV'] ||= 'development'
$env = ENV['RACK_ENV']

Mongoid.load!("config/mongoid.yml", $env)

(Dir["./app/models/*.rb"].sort + Dir["./app/api/*.rb"] + Dir["./app/routes/*.rb"].sort).each do |file|
  require file
end
