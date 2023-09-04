print('^5Boatanchor - Server Synced Boat Anchor Script^7 by Nicky of ^4The EliteRP^7')
Config = Config or {}

Config.Progressbar = {
  time = 5000,
  dropLabel = "Dropping anchor...",
  raiseLabel = "Lifting anchor...",
}

Config.Command = {
  key = 'Y',
  name = 'anchor',
  label = 'Anchor the boat',
}

Config.RadialMenu = {
  enable = true,
  dropAnchorIcon = 'anchor-circle-check',
  dropAnchorText = 'Lower Anchor',
  raiseAnchorIcon = 'anchor-circle-xmark',
  raiseAnchorText = 'Raise Anchor',
}

Config.Notify = {
  droppedAnchor = 'Anchor dropped!',
  raisedAnchor = 'Anchor lifted!',
  cancel = 'Cancelled...',
}