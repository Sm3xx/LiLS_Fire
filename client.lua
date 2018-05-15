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

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('setadmin')
AddEventHandler('setadmin', function()
	group = true
end)



Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerServerEvent( "checkadmin")
		end
	end
end )



RegisterCommand('startfire', function() --triggers a serverevent when command is typed in chat
    TriggerServerEvent("FIRE", PlayerId())
end)




RegisterNetEvent("firesync") 												--registers the Client Event, so the server can trigger it
AddEventHandler("firesync", function(player) 								--actual Event

  ESX.TriggerServerCallback('fire:randomizer', function(result)
    random_x = result[2]
    random_y = result[3]
    location = result[1]
  end)

  for i = 0, 120 do
    StartScriptFire(location[1] + random_x, location[2] + random_y, 31.3437, 25, false)
	end
end)










--[[
RegisterNetEvent("firesync") 												--registers the Client Event, so the server can trigger it
AddEventHandler("firesync", function(player) 								--actual Event
for i = 0, 120 do
    StartScriptFire(1962.453 + math.random(-7,7), 3745.419 + math.random(-7,7), 31.3437, 25, false)
	end
end)
]]
