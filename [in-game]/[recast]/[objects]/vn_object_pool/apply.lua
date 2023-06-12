local model = 2964


local txd = EngineTXD("assets/pool.txd")
txd:import(model)
local dff = EngineDFF("assets/pool.dff")
dff:replace(model)