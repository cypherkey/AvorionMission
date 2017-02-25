package.path = package.path .. ";data/scripts/lib/?.lua"

function execute(sender, commandName, ...)
    Player(sender):addScriptOnce("data/scripts/epic/start.lua")
    return 0, "", ""
end

function getDescription()
    return "Start the Epic."
end

function getHelp()
    return "Start the Epic. Usage: /startepic"
end
