Config = {}

Config.FireSpawnTimer = {                 -- min/max time in seconds
  ["minTime"] = 2400, ["maxTime"] = 3600
}

Config.autoDeleteFireTimer = 1200         -- time in seconds after which the fire will be deletet automacicly

Config.fireStackHeight = 0.35             -- space between stacked flames

Config.fireLocations = { -- x, y, z, minSpread, maxSpread, flameCount, fireType
  {["x"]=1959.8701, ["y"]=3748.1833,  ["z"]=31.3437,  ["minSpread"]=-6,  ["maxSpread"]=6, ["flames"]=200, ["label"]="Ladenbrand"},--  Sandy Shores Shop near Petrol Station
  {["x"]=1853.7718, ["y"]=3746.4409,  ["z"]=32.3951,  ["minSpread"]=-6,  ["maxSpread"]=6, ["flames"]=200, ["label"]="Ladenbrand"},--  Sandy Shores Tatoo Shop (needs to be further optimized)
}
