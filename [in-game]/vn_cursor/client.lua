local screen = Vector2(guiGetScreenSize())
setCursorAlpha(0)

addEventHandler("onClientRender", root, function()
    if (isCursorShowing()) then
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX * screen.x, cursorY * screen.y
        dxDrawImage(cursorX-7, cursorY-4, 32, 32, "assets/cursor.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
end, true, "low-9999")