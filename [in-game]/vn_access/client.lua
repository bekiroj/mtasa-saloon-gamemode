function getCamera()
    local x, y, z, lx, ly, lz = getCameraMatrix()
    outputChatBox(""..x..", "..y..", "..z..", "..lx..", "..ly..", "..lz)
end
addCommandHandler("matrix", getCamera)