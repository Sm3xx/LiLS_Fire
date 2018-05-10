
--- ADD YOUR ADMIN STEAM IDs TO WHITELIST THEM
local isFireToDelete = false

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- RegisterServerEvent('checkadmin')
-- AddEventHandler('checkadmin', function()
-- 	local id = source
-- 	if isAdmin(id) then
-- 		TriggerClientEvent("setadmin", source)
-- 	end
-- end)

RegisterServerEvent("fire:FIRE") --This registers the Server Event, so the client can trigger it
AddEventHandler("fire:FIRE", function(message) --This is the actual Event
	TriggerClientEvent("fire:firesync", -1) --This triggers a Event on every client, so the fire is visible for everyone.
end)

RegisterServerEvent("delFire")
AddEventHandler("delFire", function()
  TriggerClientEvent("delFireSync", -1)
end)



--Firespawn Randomizer
ESX.RegisterServerCallback('getloc', function(source, cb)
  local spreadTable = {}
  local locationIndex = math.floor(math.random(1, #Config.fireLocations))
  local location = Config.fireLocations[locationIndex]

  for i=1, location[6] do
    local stackFlames = math.floor(math.random(1, 100))
    local random_x = math.random(location[4], location[5])
    local random_y = math.random(location[4], location[5])
    local _table = {random_x, random_y, stackFlames}
    table.insert(spreadTable, _table)
  end

  cb({location, spreadTable, stackFlames})
end)


-- Timer for creating/deleting fire
RegisterServerEvent("fire:timeleftsync")
AddEventHandler("fire:timeleftsync", function(nTimeLeft)
  timeLeft = nTimeLeft
  if timeLeft < 1 then
    TriggerEvent("fire:FIRE")
  end
end)

Citizen.CreateThread(function()
  timeLeft = math.random(Config.FireSpawnTimer["minTime"], Config.FireSpawnTimer["maxTime"])
  clearFire = timeLeft - Config.autoDeleteFireTimer
  -- print("Next: " .. timeLeft .. " - " .. "Clear " .. clearFire)
    while true do
        Wait(1000)
        timeLeft = timeLeft - 1
        -- print("Left: " .. timeLeft .. " - " .. "Clear: " .. clearFire .. " Del. Fire: " .. tostring(isFireToDelete))
        TriggerEvent("fire:timeleftsync", timeLeft)

        if timeLeft < 1 then
          timeLeft = math.random(Config.FireSpawnTimer["minTime"], Config.FireSpawnTimer["maxTime"])
          clearFire = timeLeft - Config.autoDeleteFireTimer
          isFireToDelete = true;
          -- print("Next: " .. timeLeft .. " - " .. "Clear " .. clearFire)
        end

        if timeLeft <= clearFire and isFireToDelete then
          TriggerClientEvent("fire:delFireSync", -1)
          -- print("Fire deleted")
          isFireToDelete = false
        end
    end
end)
