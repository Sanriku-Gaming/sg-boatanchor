local QBCore = exports['qb-core']:GetCoreObject()

local anchoredBoats = {}
local radial = Config.RadialMenu
local command = Config.Command
local progress = Config.Progressbar
local notify = Config.Notify
local xsound = false
local radialMenu = false
local anchorMenu = {
  id = 'toggle_anchor',
  title = radial.dropAnchorText,
  icon = radial.dropAnchorIcon,
  type = 'client',
  event = 'sg-boatanchor:client:ToggleAnchor',
  shouldClose = true,
}

local function rebuildMenu(anchored)
  exports['qb-radialmenu']:RemoveOption(23)
  anchorMenu.icon = anchored and radial.raiseAnchorIcon or radial.dropAnchorIcon
  anchorMenu.title = anchored and radial.raiseAnchorText or radial.dropAnchorText
  Wait(500)
  exports['qb-radialmenu']:AddOption(anchorMenu, 23)
end

-- Register Key
RegisterKeyMapping(command.name, command.label, 'keyboard', command.key)
RegisterCommand(command.name, function()
    if IsPedInAnyBoat(PlayerPedId(), false) then
        TriggerEvent("sg-boatanchor:client:ToggleAnchor")
    end
end, false)

-- Events
RegisterNetEvent('sg-boatanchor:client:setAnchoredBoats', function(serverAnchoredBoats)
  anchoredBoats = serverAnchoredBoats
end)

RegisterNetEvent('sg-boatanchor:client:ToggleAnchor', function()
  local ped = PlayerPedId()
  local boat = GetVehiclePedIsIn(ped)
  if boat then
    local boatNetId = VehToNet(boat)
    -- Get current anchored status
    local boatAnchored = anchoredBoats[boatNetId]
    local currentAnchored = boatAnchored and boatAnchored.anchored
    -- Toggle to get new status
    local newAnchored = not currentAnchored
    -- Messages based on new status
    local pMessage = newAnchored and progress.dropLabel or progress.raiseLabel
    local nMessage = newAnchored and notify.droppedAnchor or notify.raisedAnchor
    local sound = newAnchored and "anchordown" or "anchorup"
    -- Anchor toggle logic
    if xsound then
      TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, sound, 0.6)
    end
    QBCore.Functions.Progressbar("toggleanchor", pMessage, progress.time, false, true, {
      disableMovement = false,
      disableCarMovement = true,
      disableMouse = false,  
      disableCombat = true
    }, {}, {}, {}, function() -- Done
      QBCore.Functions.Notify(nMessage, "success")
      if radial.enable then
        rebuildMenu(newAnchored)
      end
      SetBoatAnchor(boat, newAnchored)
      SetBoatFrozenWhenAnchored(boat, newAnchored)
      TriggerServerEvent('sg-boatanchor:server:setAnchor', boatNetId, newAnchored)
    end, function() -- Cancel
      QBCore.Functions.Notify(notify.cancel, "error", 5000)
    end)
  end
end)

RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
  local ped = PlayerPedId()
  local boat = GetVehiclePedIsIn(ped)
  if IsPedInAnyBoat(ped) then
    local boatNetId = VehToNet(boat)
    if anchoredBoats[boatNetId] and anchoredBoats[boatNetId].anchored then
      local anchored = anchoredBoats[boatNetId].anchored
      if radial.enable then
        rebuildMenu(anchored)
      end
      SetBoatAnchor(boat, anchored)
      SetBoatFrozenWhenAnchored(boat, anchored)
    end
    exports['qb-radialmenu']:AddOption(anchorMenu, 23)
    radialMenu = true
  end
end)

RegisterNetEvent('QBCore:Client:LeftVehicle', function()
  if radial.enable then
    if radialMenu then
      exports['qb-radialmenu']:RemoveOption(23)
      radialMenu = false
    end
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  if GetResourceState('xsound') == 'started' then
    xsound = true
  end
end)