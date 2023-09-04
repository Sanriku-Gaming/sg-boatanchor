local QBCore = exports['qb-core']:GetCoreObject()
local anchoredBoats = {}

QBCore.Functions.CreateCallback('sg-boatanchor:server:isBoatAnchored', function(source, cb, boatNetId)
  if anchoredBoats[boatNetId] then
    cb(anchoredBoats[boatNetId].anchored)
  else
    cb(false)
  end
end)

RegisterNetEvent('sg-boatanchor:server:setAnchor', function(boatNetId, isAnchored)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player and boatNetId then
    anchoredBoats[boatNetId] = {
      anchored = isAnchored  
    }
    TriggerClientEvent('sg-boatanchor:client:setAnchoredBoats', -1, anchoredBoats)
  end
end)