# Multiboot Jirachi Emulator Patches

These patches allow redeeming a multiboot Jirachi (Wishmaker, Meteor, and Wishing Star) on an emulator without Dolphin.

The patches remove:

- The Gamecube handshake
- The chipset check
- The game code check

## Differences between redemption

Differences:

- Wishmaker uses a save seed with TID 20043 and a broken shiny lock
- Meteor uses a save seed with TID 30719, a broken shiny lock, and the same generation as Wishmaker
- Wishing star uses an RTC seed with TID 30719, a working shiny lock, and different generation than the other two

In other words:

- Meteor has different shinies than Wishmaker
- Wishing star is the easiest, since it's an RTC seed, but no shinies
- Wishing star has different spreads

## Building the patches

1. Dump the multiboot roms from the Wishmaker bonus disc and put them in the repo directory
2. Install [armips](https://github.com/Kingcom/armips) and [flips](https://github.com/Alcaro/Flips)
3. Run `make`

## Using the rng reference

1. Install rust
2. Run `cargo run -- --help` in the rng reference directory
