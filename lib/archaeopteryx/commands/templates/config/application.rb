require 'bundler/setup'

Bundler.require :default

class <%= app_const %> < Archaeopteryx::Application
  load_clips!
  load_instruments!
end
