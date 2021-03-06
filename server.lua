--variable to check if there is a fire to delete, so it wont try to delete very second
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

-- trigger fire spawn event for all clients
RegisterServerEvent("fire:FIRE")                                                --This registers the Server Event, so the client can trigger it
AddEventHandler("fire:FIRE", function(message)                                  --This is the actual Event
	TriggerClientEvent("fire:firesync", -1)                                       --This triggers a Event on every client, so the fire is visible for everyone.
end)

-- trigger fire delete event for all clients
RegisterServerEvent("delFire")
AddEventHandler("delFire", function()
  TriggerClientEvent("delFireSync", -1)
end)



--  get fire spawn location
ESX.RegisterServerCallback('getloc', function(source, cb)
  local spreadTable = {}                                                        -- creates empty array
  local locationIndex = math.floor(math.random(1, #Config.fireLocations))       -- generates a random number between 1 and the max count of entrys in the fireLocations array
  local location = Config.fireLocations[locationIndex]                          -- reads out the location at the index of the random number

  for i=1, location[6] do                                                       -- run as often as specified as flamecount in the config
    local stackFlames = math.floor(math.random(1, 100))                         -- create random number between 1 and 100
    local random_x = math.random(location[4], location[5])                      -- crate random number between min/max Spread specified in the config for the location
    local random_y = math.random(location[4], location[5])                      -- crate random number between min/max Spread specified in the config for the location
    local _table = {random_x, random_y, stackFlames}                            -- create an array out of the three values
    table.insert(spreadTable, _table)                                           -- insert the previously generated array into the returning table
  end

  cb({location, spreadTable, stackFlames})                                      -- return the location, the random spreads and the stack height for the flames
end)


-- Timer for creating/deleting fire
RegisterServerEvent("fire:timeleftsync")
AddEventHandler("fire:timeleftsync", function(nTimeLeft)                        -- check if timer for the next fire is over
  timeLeft = nTimeLeft                                                          -- set timeLeft to nTimeLeft
  if timeLeft < 1 then
    TriggerEvent("fire:FIRE")                                                   -- trigger the next fire spawn event
  end
end)

Citizen.CreateThread(function()
  timeLeft = math.random(Config.FireSpawnTimer["minTime"], Config.FireSpawnTimer["maxTime"])    -- create first timer for the fire spawn
  clearFire = timeLeft - Config.autoDeleteFireTimer                             -- set the count the timer needs to fall below to clear the fire
    while true do
        Wait(1000)
        timeLeft = timeLeft - 1                                                 -- substract 1 every second from the timer
        TriggerEvent("fire:timeleftsync", timeLeft)                             -- trigger the sync event

        if timeLeft < 1 then                                                    -- create new counter and clear counter if fire is spawned
          timeLeft = math.random(Config.FireSpawnTimer["minTime"], Config.FireSpawnTimer["maxTime"])
          clearFire = timeLeft - Config.autoDeleteFireTimer
          isFireToDelete = true;
        end

        if timeLeft <= clearFire and isFireToDelete then                        -- if fire is spawned and the timer is below the clear timer
          TriggerClientEvent("fire:delFireSync", -1)                            -- delete the fire for all clients
          isFireToDelete = false
        end
    end
end)
