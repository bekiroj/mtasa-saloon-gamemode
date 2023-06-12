local model = 334


local txd = EngineTXD("assets/bat.txd")
txd:import(model)
local dff = EngineDFF("assets/bat.dff")
dff:replace(model)