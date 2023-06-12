local model = 3082


local txd = EngineTXD("assets/picture.txd")
txd:import(model)
local dff = EngineDFF("assets/picture.dff")
dff:replace(model)