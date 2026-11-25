require 'rspec'
require 'rspec/its'

begin
  require 'rcoremidi'
rescue LoadError
  # The driver only builds on macOS; elsewhere run the pure-Ruby specs against
  # a stand-in that does no MIDI I/O (see spec/stubs/rcoremidi.rb).
  $LOAD_PATH.unshift File.expand_path('stubs', __dir__)
  require 'rcoremidi'
end
require 'archaeopteryx'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |file| load file }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  # Specs tagged :coremidi need real CoreMIDI devices (an IAC Driver bus).
  config.filter_run_excluding :coremidi if defined?(RCoreMidi::STUBBED)

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
