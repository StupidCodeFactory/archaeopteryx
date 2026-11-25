require 'spec_helper'
require 'archaeopteryx/cli'
require 'tmpdir'

RSpec.describe Archaeopteryx::Commands::New, :coremidi do
  let(:application_name) { 'dummy_app' }
  let(:application_file) { File.join(application_name, 'config', described_class::APPLICATION) }

  around do |example|
    Dir.mktmpdir { |dir| Dir.chdir(dir) { example.run } }
  end

  before do
    expect { described_class.start([application_name]) }.to output.to_stdout
  end

  it 'creates the application folder structure' do
    Archaeopteryx::CLI::DIRS.each do |dir|
      expect(File).to be_directory(File.join(application_name, dir))
    end
  end

  it 'writes the application class named after the folder' do
    expect(File.read(application_file)).to include('class DummyApp < Archaeopteryx::Application')
  end
end
