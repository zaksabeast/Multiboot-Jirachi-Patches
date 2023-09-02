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

## Wishing Star error screenshots

These aren't translated. I patched the game for the different error cases and took a screenshot of the message that appeared.

| Screenshot                                                                 | Error                                                                                                                                           |
| -------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| ![No Pokedex](wishing_star_screenshots/no_pokedex.png)                     | No Pokedex                                                                                                                                      |
| ![No Save](wishing_star_screenshots/no_save.png)                           | No Save                                                                                                                                         |
| ![Party Full](wishing_star_screenshots/party_full.png)                     | Party Full                                                                                                                                      |
| ![Corrupted Save](wishing_star_screenshots/corrupted_save.png)             | Corrupted Save                                                                                                                                  |
| ![Failed chipset check](wishing_star_screenshots/failed_chipset_check.png) | The text translates to "Received Jirachi", but the Jirachi image is not shown. If I recall correctly, this is caused by a failed chipset check. |
