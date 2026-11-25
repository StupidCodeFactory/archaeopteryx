require 'spec_helper'
require 'archaeopteryx/cli'
require 'tmpdir'

RSpec.describe Archaeopteryx::CLI, :coremidi do
  around do |example|
    Dir.mktmpdir { |dir| Dir.chdir(dir) { example.run } }
  end

  describe 'new' do
    it 'generates a new application' do
      expect { described_class.start(%w[new dummy]) }.to output.to_stdout

      expect(File).to be_file(File.join('dummy', 'config', Archaeopteryx::Commands::New::APPLICATION))
    end
  end
end
