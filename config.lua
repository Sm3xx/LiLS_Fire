Config = {}

Config.FireSpawnTimer = {   -- min/max time in seconds
  ["minTime"] = 2400, ["maxTime"] = 3600
}

Config.autoDeleteFireTimer = 1200   -- time in seconds after which the fire will be deletet automacicly

Config.fireStackHeight = 0.4    -- space between stacked flames

Config.fireLocations = { -- x, y, z, minSpread, maxSpread, flameCount, fireType
  {1959.8701, 3748.1833,  31.3437,  -6,  6, 200, "Ladenbrand"},       --  Sandy Shores Shop near Petrol Station
  {1853.7718, 3746.4409,  32.3951,  -6,  6, 200, "Ladenbrand"},       --  Sandy Shores Tatoo Shop (needs to be further optimized)
}
