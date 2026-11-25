require 'spec_helper'
require 'archaeopteryx/cli'
require 'tmpdir'

RSpec.describe Archaeopteryx::Commands::Generate do
  around do |example|
    Dir.mktmpdir { |dir| Dir.chdir(dir) { example.run } }
  end

  describe 'clip' do
    it 'writes a clip registered under the given name' do
      expect { Archaeopteryx::CLI.start(%w[generate clip drum]) }.to output.to_stdout

      expect(File.read(File.join('clips', 'drum.rb'))).to include('Archaeopteryx::Clip.register :drum do')
    end
  end
end
