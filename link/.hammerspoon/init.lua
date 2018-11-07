hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")
spoon.ReloadConfiguration:start()

hs.window.animationDuration = 0.0

if spoon.WinWin then
    spoon.ModalMgr:new("windowM")
    local cmodal = spoon.ModalMgr.modal_list["windowM"]
    cmodal:bind('', 'escape', 'Deactivate window management', function() spoon.ModalMgr:deactivate({"windowM"}) end)
    cmodal:bind('', 'Q', 'Deactivate window management', function() spoon.ModalMgr:deactivate({"windowM"}) end)

    cmodal:bind('', 'left', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    cmodal:bind('', 'right', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    cmodal:bind('', 'up', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    cmodal:bind('', 'down', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)

    cmodal:bind({'shift', 'ctrl'}, 'left', 'Lefthalf of Screen', function() spoon.WinWin:moveAndResize("halfleft") end)
    cmodal:bind({'shift', 'ctrl'}, 'right', 'Righthalf of Screen', function() spoon.WinWin:moveAndResize("halfright") end)
    cmodal:bind({'shift', 'ctrl'}, 'up', 'Uphalf of Screen', function() spoon.WinWin:moveAndResize("halfup") end)
    cmodal:bind({'shift', 'ctrl'}, 'down', 'Downhalf of Screen', function() spoon.WinWin:moveAndResize("halfdown") end)

    -- cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:moveAndResize("cornerNW") end)
    -- cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:moveAndResize("cornerNE") end)
    -- cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:moveAndResize("cornerSW") end)
    -- cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:moveAndResize("cornerSE") end)

    cmodal:bind('', 'space', 'Fullscreen', function() spoon.WinWin:moveAndResize("fullscreen") end)
    cmodal:bind('', 'tab', 'Center Window', function() spoon.WinWin:moveAndResize("center") end)
    cmodal:bind('', '.', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    cmodal:bind('', ',', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)

    cmodal:bind('shift', 'left', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    cmodal:bind('shift', 'right', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    cmodal:bind('shift', 'up', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    cmodal:bind('shift', 'down', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)

    cmodal:bind({'alt', 'ctrl'}, 'left', 'Move to Left Monitor', function() spoon.WinWin:moveToScreen("left") end)
    cmodal:bind({'alt', 'ctrl'}, 'right', 'Move to Right Monitor', function() spoon.WinWin:moveToScreen("right") end)
    cmodal:bind({'alt', 'ctrl'}, 'up', 'Move to Above Monitor', function() spoon.WinWin:moveToScreen("up") end)
    cmodal:bind({'alt', 'ctrl'}, 'down', 'Move to Below Monitor', function() spoon.WinWin:moveToScreen("down") end)
    cmodal:bind({'alt', 'ctrl'}, 'space', 'Move to Next Monitor', function() spoon.WinWin:moveToScreen("next") end)

    cmodal:bind('', 'z', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
    cmodal:bind('', 'c', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

    -- Register windowM with modal supervisor
    hsresizeM_keys = hsresizeM_keys or {{"ctrl", "alt", "cmd"}, "."}
    if string.len(hsresizeM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter window management", function()
            -- Deactivate some modal environments or not before activating a new one
            spoon.ModalMgr:deactivateAll()
            -- Show an status indicator so we know we're in some modal environment now
            spoon.ModalMgr:activate({"windowM"}, "#B22222")
        end)
    end
end


spoon.ModalMgr.supervisor:enter()
