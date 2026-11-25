require 'bundler/setup'

Bundler.require :default

class ModularDemo < Archaeopteryx::Application
  load_clips!
  load_instruments!
end
