require 'bundler/setup'

Bundler.require :default

class ClockCheck < Archaeopteryx::Application
  load_clips!
  load_instruments!
end
