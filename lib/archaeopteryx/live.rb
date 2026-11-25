require 'archaeopteryx/duration_calculator'

module Archaeopteryx
  class Live
    attr_reader :instruments

    def generate_beats(bar: 0)
      Instrument.all.flat_map do |instrument|
        instrument.generate_bar(bar)
      end
    end
  end
end
