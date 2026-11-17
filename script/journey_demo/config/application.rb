require 'bundler/setup'

Bundler.require :default

class JourneyDemo < Archaeopteryx::Application
  load_clips!
  load_instruments!
end
