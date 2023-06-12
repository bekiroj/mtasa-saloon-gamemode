local model = 482


local txd = EngineTXD("assets/pony.txd")
txd:import(model)
local dff = EngineDFF("assets/pony.dff")
dff:replace(model)