if onServer() then

function initialize()
    local player = Player()
    local x, y = Sector():getCoordinates()
    local faction = Galaxy():getLocalFaction(x, y)
    local hx, hy = faction:getHomeSectorCoordinates()

    player:sendChatMessage("Server", 0, string.format("The factions home base is at %s:%s", x, y))
    terminate()
end

end
