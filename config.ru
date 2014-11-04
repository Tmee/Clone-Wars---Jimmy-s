$:.unshift File.expand_path("./../lib", __FILE__)
require 'bundler'
if ENV['RACK_ENV'] == 'production'
  Bundler.require(:default, :production)
else
  Bundler.require(:default, :development)
end
require 'app'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/app'
require 'yaml/store'

run JimmysApp
