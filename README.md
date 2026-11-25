# Archaeopteryx

Live coding MIDI in Ruby. You write clips (rhythmic and melodic patterns) and
instruments (which clip plays on which bar, on which MIDI channel) as plain
Ruby files. Then you start a session that follows an external MIDI clock from
your DAW or drum machine. Edit a file while it plays and the change is heard
from the next bar Archaeopteryx prepares, one beat ahead of the bar.

Archaeopteryx is built on [rcoremidi](https://github.com/StupidCodeFactory/rcoremidi),
a C extension for macOS CoreMIDI. rcoremidi receives the clock and schedules
timestamped notes. Archaeopteryx decides which notes to play and when.

## Requirements

- macOS. rcoremidi wraps CoreMIDI, so it does not build anywhere else.
- Ruby 3.1 or later.
- A MIDI clock source and a synth listening on a MIDI port. The IAC Driver
  (Audio MIDI Setup > MIDI Studio > IAC Driver > "Device is online") gives
  you a virtual bus between Archaeopteryx and your DAW.

## Install

```bash
gem install archaeopteryx
```

Clip keys and chords use [musicalism](https://github.com/StupidCodeFactory/musicalism),
which is not on rubygems.org yet. Add it to your application's Gemfile from git
or a local checkout:

```ruby
gem 'archaeopteryx'
gem 'musicalism', github: 'StupidCodeFactory/musicalism'
```

To work on Archaeopteryx itself, check out `rcoremidi` and `musicalism` next to
this repository, or set `RCOREMIDI_PATH` and `MUSICALISM_PATH`. Then compile
the driver and run the specs:

```bash
(cd ../rcoremidi && bundle install && bundle exec rake compile)
bundle install
bundle exec rake spec
```

## Quickstart

```bash
arcx new my_set        # app skeleton; MIDI in/out default to IAC Driver Bus 1
cd my_set
arcx connections       # list MIDI inputs and outputs with their unique IDs
arcx generate clip drum
arcx start             # wait for the clock (add -d to run in the background)
arcx status            # in another shell: is the session running?
arcx stop
```

`arcx new` creates `clips/`, `instruments/`, `config/application.rb` and
`config/connections.yml`. `connections.yml` names the client and the unique IDs
of its MIDI input (the clock) and output (the notes). Edit it with IDs from
`arcx connections` to use other ports.

Archaeopteryx follows the clock and does not send one. Press play in the DAW
(sending MIDI clock to the input port), and the session plays bar 1 from the
DAW's Start. It also handles Stop and Continue. The tempo is measured from the
clock, and `config.bpm` (default 120) is the fallback before the first clocks
arrive.

### A clip

```ruby
# clips/progression.rb
Archaeopteryx::Clip.register :progression do
  key 'A minor'

  note 'E5', 16, [1, 0, 0, 0] * 4                  # a pitch, 16 steps per bar
  note 1, 16, [0.9, 0, 0.3, 0] * 4                 # scale degree 1 of the key
  chord :iv, 16, [1, 0, 0, 0, 0, 0, 0, 0] * 2, inversion: 1
end
```

Each step is the probability that the note plays, from 0.0 to 1.0. Probability
only applies when the instrument enables it (see below). Otherwise any value
above 0 plays.

`modulate` plays one voice-led chord per bar, taking you to another key
through a pivot chord:

```ruby
Archaeopteryx::Clip.register :pads do
  key 'C major'
  modulate to: 'G major', via: :vi, rhythm: [1, 0, 1, 0] * 4
end
```

### An instrument

```ruby
# instruments/keys.rb
Archaeopteryx::Instrument.register :keys, 0 do   # MIDI channel 1
  play 1..8, :progression           # bars 1 to 8
  play 9..16, :pads, true           # true enables the step probabilities
end
```

Save either file while the session runs, and it is reloaded in place. The
next bar to be prepared uses the new version.

## How it works

`Archaeopteryx::Client` subclasses `RCoreMidi::Client` and overrides its clock
hooks (`on_start`, `on_tick`, `on_stop`, `on_continue`). One beat before each
bar, it asks every instrument for that bar's notes. It turns them into clock
positions and sends each note a few ticks ahead with
`send_packets`, timed from the measured tick period. See
[MIDI_FLOW_DIAGRAM.md](MIDI_FLOW_DIAGRAM.md) for the full path, and
`script/clock_lab` for a tool that checks note timing against a clock.

## History

This project started from [Giles Bowkett's archaeopteryx](https://github.com/gilesbowkett/archaeopteryx)
(2008), a probabilistic MIDI step sequencer and collection of music hacks in
Ruby. This repository began as a 2008 fork of it. Its probabilistic step
sequencing inspired the clips here.

The live coding layer was then written inside the rcoremidi gem (from 2010)
and moved here when rcoremidi became a driver-only gem. Both histories are
preserved in this repository. The original archaeopteryx code, with Giles
Bowkett's MIT license (`mit_license.txt`), is in the commits before the merge
of the rcoremidi history. You can browse it with
`git show 6fec6b9:mit_license.txt` or `git log -- README`.

## License

MIT, see [LICENSE](LICENSE). The original archaeopteryx code in this
repository's history keeps its own MIT license (Copyright 2008 Giles Bowkett
and contributors).
