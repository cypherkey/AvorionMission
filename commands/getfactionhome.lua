package.path = package.path .. ";data/scripts/lib/?.lua"

function execute(sender, commandName, ...)
    Player(sender):addScriptOnce("cmd/getfactionhome.lua")
    return 0, "", ""
end

function getDescription()
    return "Return the coordinates of the factions home sector."
end

function getHelp()
    return "Return the coordinates of the factions home sector. Usage: /echo This is a test"
end
