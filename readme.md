# Boat Anchor Script

A QBCore boat anchoring solution with synchronized anchor state across clients.

## Features

- Server synced anchor status
- Radial menu integration
- Anchor drop/raise effects and sounds
- Progressbar feedback
- Notifications

## Requirements

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu) (optional)
- [xsound](https://github.com/Xogy/xsound) (optional, for anchor sounds)

## Installation

1. Download the script
2. Place `sg-boatanchor` into your `resources` or `standalone` folder (remove `-main` from folder if necessary)
3. Place sound files from `sg-boatanchor\assets` into the `xsound\html\sounds` folder
4. Add `ensure sg-boatanchor` to your server.cfg (after all qb scripts), unless in `standalone` folder
5. Configure options in `config.lua` to your liking
6. Restart/start your server

## Configuration

All configuration options can be found in the `config.lua` file.

Some key options:

- `Config.Progressbar` - Customize the progress bar labels and timing
- `Config.Command` - Set a slash command for anchoring
- `Config.RadialMenu` - Toggle and customize the radial menu options
- `Config.Notify` - Adjust the anchor notification messages

## Usage

- Use the slash command `/anchor` to toggle the anchor
- Use the boat anchor radial menu option
- Use the default keybind `Y` to toggle anchor

## Credits

- [Nicky](https://forum.cfx.re/u/Sanriku)
- [SG Scripts Discord](https://discord.gg/uEDNgAwhey)