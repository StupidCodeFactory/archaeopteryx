require 'spec_helper'
require 'archaeopteryx/cli'

RSpec.describe Archaeopteryx::Live do
  let(:fixtures_root) { Archaeopteryx::AppPathname.new(File.join('spec', 'fixtures')) }
  let(:duration_calculator) { Archaeopteryx::DurationCalculator.new(120) }

  before do
    allow(Archaeopteryx::Application).to receive(:root).and_return(fixtures_root)
    Archaeopteryx::Application.load_clips!
    Archaeopteryx::Application.load_instruments!
  end

  describe '#generate_beats' do
    it 'returns the notes every instrument plays on the bar' do
      expect(subject.generate_beats(bar: 1)).to eq([
        Archaeopteryx::Note.new('E5', *duration_calculator.timestamps_for(0)),
        Archaeopteryx::Note.new('E5', *duration_calculator.timestamps_for(4)),
        Archaeopteryx::Note.new('E5', *duration_calculator.timestamps_for(8)),
        Archaeopteryx::Note.new('E5', *duration_calculator.timestamps_for(12))
      ])
    end
  end
end
