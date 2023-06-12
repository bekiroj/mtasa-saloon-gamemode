local _print = outputDebugString

addEvent("anticheat.kick", true)
addEventHandler("anticheat.kick", root, function()
    _print("!ANTİCHEAT - "..source.name.." kicked server")
    source:kick(source, "bekir caught you")
end)