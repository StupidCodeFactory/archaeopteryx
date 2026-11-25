# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'archaeopteryx/version'

Gem::Specification.new do |s|
  s.name = 'archaeopteryx'
  s.version = Archaeopteryx::VERSION
  s.authors = ['StupidCodeFactory <ymarquet@gmail.com>']
  s.email = ['ymarquet@gmail.com']
  s.homepage = 'https://github.com/StupidCodeFactory/archaeopteryx'
  s.license = 'MIT'
  s.summary = 'Live coding MIDI in Ruby on top of rcoremidi'
  s.description = <<~DESC
    Archaeopteryx is a live coding environment for MIDI: write clips and
    instruments in Ruby, start a session with `arcx start`, and edit the files
    while it plays in time with an external MIDI clock. It drives macOS
    CoreMIDI through the rcoremidi gem.
  DESC

  s.required_ruby_version = '>= 3.2'
  s.files = Dir['lib/**/*', 'bin/arcx', 'README.md', 'LICENSE', 'MIDI_FLOW_DIAGRAM.md']
  s.bindir = 'bin'
  s.executables = ['arcx']
  s.require_paths = ['lib']

  s.add_dependency 'listen'
  s.add_dependency 'logger'
  s.add_dependency 'musicalism', '>= 0.0.1'
  s.add_dependency 'observer'
  s.add_dependency 'rcoremidi', '~> 0.1'
  s.add_dependency 'thor'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
end
