Config = {}

-- Testweise
Config.FireSpawnTimer = {   -- minimal / maximal time between firespawns
  ["minTime"] = 20, ["maxTime"] = 25
}
-- Testweise


-- Config.FireSpawnTimer = {
--   ["minTime"] = 2400, ["maxTime"] = 3600
-- }

Config.autoDeleteFireTimer = 15   -- time after which the fire will be deletet automacicly

Config.fireStackHeight = 0.4    -- space between stacked flames

Config.fireLocations = { -- x, y, z, minSpread, maxSpread, flameCount, fireType
  {1959.8701, 3748.1833,  31.3437,  -6,  6, 200, "Ladenbrand"},
  -- {1853.7718, 3746.4409,  32.3951,  -6,  6, 200}
}
