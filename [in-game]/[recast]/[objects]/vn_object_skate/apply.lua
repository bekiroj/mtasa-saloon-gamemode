local model = 2405

local txd = EngineTXD("assets/skate.txd")
txd:import(model)
local dff = EngineDFF("assets/skate.dff")
dff:replace(model)

local model = 2404

local txd = EngineTXD("assets/skate2.txd")
txd:import(model)
local dff = EngineDFF("assets/skate2.dff")
dff:replace(model)