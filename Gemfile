source 'https://rubygems.org'

gemspec

# The CoreMIDI driver. Point RCOREMIDI_PATH at a local checkout (built with
# `bundle exec rake compile` there) while both gems are developed together.
gem 'rcoremidi', path: ENV.fetch('RCOREMIDI_PATH', '../rcoremidi')
# Not published on rubygems.org: https://github.com/StupidCodeFactory/musicalism
gem 'musicalism', path: ENV.fetch('MUSICALISM_PATH', '../musicalism')
gem 'debug'
