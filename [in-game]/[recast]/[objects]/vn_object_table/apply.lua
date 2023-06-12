local model = 1433


local txd = EngineTXD("assets/table.txd")
txd:import(model)
local dff = EngineDFF("assets/table.dff")
dff:replace(model)