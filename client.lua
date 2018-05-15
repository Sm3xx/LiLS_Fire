local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local admins = {
    'steam:11000010cd94f4aa'
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

location = nil
fire = {}
timeLeft = nil
clearFireTimer = nil

isFireToDelete = false


-- function for debugging
function Chat(t)
  TriggerEvent("chatMessage", "DEBUG", {255, 0, 0}, "" .. tostring(t))
end


RegisterNetEvent("fire:firesync") 												  --  registers the Client Event, so the server can trigger it
AddEventHandler("fire:firesync", function() 								--  actual Event

  ESX.TriggerServerCallback('getloc', function(result)      --  Trigger Callback to get one random Location for all Clients
    location = result[1]                                    --  Read Coordinates from the array
    spreadTable = result[2]                                 --  Read max radius the fire is spread out

    for i = 1, #spreadTable do                              --  Run the amount specified in the Config (flamecount)
      spread = spreadTable[i]                               --  Reading min/max Fire spread of Location array
      stackFlames = spread[3]                               --  Reading the randomized stacking height for the flames
      table.insert(fire, StartScriptFire(location[1] + spread[1], location[2] + spread[2], location[3], 25, false))   --  creating flames and insert it into an array for later deletion

      if stackFlames > 95 then
        table.insert(fire, StartScriptFire(location[1] + spread[1], location[2] + spread[2], location[3] + 4 * Config.fireStackHeight, 25, false))
      end

      if stackFlames <= 85 then
        table.insert(fire ,StartScriptFire(location[1] + spread[1], location[2] + spread[2], location[3] + 3 * Config.fireStackHeight, 25, false))
      end

      if stackFlames <= 50 then
        table.insert(fire, StartScriptFire(location[1] + spread[1], location[2] + spread[2], location[3] + 2 * Config.fireStackHeight, 25, false))
      end

      if stackFlames <= 15 then
        table.insert(fire, StartScriptFire(location[1] + spread[1], location[2] + spread[2], location[3] + Config.fireStackHeight, 25, false))
      end

    end

    local street = GetStreetNameAtCoord(location[1], location[2], location[3])      -- reading streetname from the firelocation

    -- Trigger Dispatch for ambulance/firefighters
    TriggerServerEvent('esx_phone:send', 'ambulance', "Hilfe ein " .. location[7] .. " in der " .. GetStreetNameFromHashKey(street), true, {
      x = location[1],
      y = location[2],
      z = location[2]
    })

    -- Chat("Fire created.") -- Message for debugging
  end)
end)

RegisterNetEvent("fire:delFireSync")                        --  registers the Client Event, so the server can trigger it
AddEventHandler("fire:delFireSync", function()              --  actual Event
  for i=1, #fire do                                   --  run through the fire array
    RemoveScriptFire(fire[i])                         --  remove every fire that have been spawned
  end
  fire = {}                                           --  clearing the array
  -- Chat("Fire deleted") -- Message for debugging
end)


-- RegisterNetEvent('setadmin')
-- AddEventHandler('setadmin', function()
-- 	group = true
-- end)


-- Citizen.CreateThread(function()
-- 	while true do
-- 		-- Wait 5 seconds after player has loaded in and trigger the event.
-- 		Citizen.Wait( 5000 )
--
-- 		if NetworkIsSessionStarted() then
-- 			TriggerServerEvent("checkadmin")
-- 		end
-- 	end
-- end)
--
-- function isAdmin(player)
--     local allowed = false
--     for i,id in ipairs(admins) do
--         for x,pid in ipairs(GetPlayerIdentifiers(player)) do
--             if string.lower(pid) == string.lower(id) then
--                 allowed = true
--             end
--         end
--     end
--     return allowed
-- end

-- RegisterCommand('startfire', function() --triggers a serverevent when command is typed in chat
--   TriggerServerEvent("fire:FIRE")
-- end)
--
-- RegisterCommand('delfire', function() --triggers a serverevent when command is typed in chat
--   TriggerServerEvent("fire:delFire")
-- end)
