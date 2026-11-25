source 'https://rubygems.org'

gemspec

# The CoreMIDI driver. Point RCOREMIDI_PATH at a local checkout (built with
# `bundle exec rake compile` there) while both gems are developed together.
gem 'rcoremidi', path: ENV.fetch('RCOREMIDI_PATH', '../rcoremidi')
# Local musicalism checkout while both gems are developed together.
gem 'musicalism', path: ENV.fetch('MUSICALISM_PATH', '../musicalism')
gem 'debug'
