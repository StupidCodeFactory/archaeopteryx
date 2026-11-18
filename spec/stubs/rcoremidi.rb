# Stand-in for the rcoremidi driver gem, loaded by spec_helper only when the
# real gem cannot be required (it is a CoreMIDI C extension and only builds on
# macOS). It copies the Ruby half of RCoreMidi::Client from rcoremidi and
# replaces the C half with methods that do nothing, so the pure-Ruby specs
# can run anywhere. Nothing here talks to MIDI: specs that need real devices
# must run on macOS against the real gem.
module RCoreMidi
  STUBBED = true

  module HostTime
    # The real conversion uses the mach timebase (1:1 on Intel Macs).
    def self.to_nanoseconds(host_time) = host_time
    def self.from_nanoseconds(nanoseconds) = nanoseconds.round
  end

  class MIDIObject
    def self.find_by_unique_id(_uid) = nil
  end

  class Device < MIDIObject
    def self.all = []
  end

  class Entity < MIDIObject; end
  class Source < MIDIObject; end
  class Destination < MIDIObject
    attr_reader :name

    # The real gem searches Device.all; there are no devices here.
    def self.named(name)
      raise ArgumentError, "No MIDI destination named \"#{name}\""
    end
  end

  class Client
    TICKS_PER_QUARTER = 24
    TimedNote = Struct.new(:on, :on_timestamp, :off, :off_timestamp)

    attr_accessor :midi_in, :midi_out
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def on_start(host_time); end
    def on_tick(tick, host_time); end
    def on_stop; end
    def on_continue; end

    def connect!
      connect_to midi_in
    end

    # C methods in the real gem.
    def connect_to(_source); end
    def start; end
    def stop; end
    def running? = false
    def silence; end
    def dropped_clock_events = 0
    def dispose; end
    def send_packets(_destination, _notes, _base_host_time = 0); end
  end
end
