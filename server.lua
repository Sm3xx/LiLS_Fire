ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--- ADD YOUR ADMIN STEAM IDs TO WHITELIST THEM
local admins = {
    'steam:1100001053d20f3',
}

fireLocations = {
  {1959.8701,	3748.1833,	32.3437,	-7,	7}
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end



RegisterServerEvent('checkadmin')
AddEventHandler('checkadmin', function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("setadmin", source)
	end
end)



RegisterServerEvent("FIRE") --This registers the Server Event, so the client can trigger it

AddEventHandler("FIRE", function(player) --This is the actual Event
  if isAdmin(source) then
		TriggerClientEvent("firesync", -1, player) --This triggers a Event on every client, so the fire is visible for everyone.
	end
end)


--Firespawn Randomizer
ESX.RegisterServerCallback('fire:randomizer', function(source, cb)
--	local location = fireLocations[math.random(1, #fireLocations)]
	local location = fireLocations[1]
    local random_x = math.random(location[4], location[5])
    local random_y = math.random(location[4], location[5])
	print(location)
    cb({location, random_x, random_y})
end)
