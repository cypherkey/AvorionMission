package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("galaxy")
local ShipGenerator = require ("shipgenerator")

local ships = {}

function secure()
    return {ships = ships}
end

function restore(data)
    ships = data.ships
end

function initialize()
    local x, y = Sector():getCoordinates()
    local faction = Galaxy():getLocalFaction(x, y)
    local hx, hy = faction:getHomeSectorCoordinates()

    if hx == x and hy == y then
        createShip(faction)
    else
        terminate()
        return
    end
end

function getUpdateInterval()
    return 5
end

function onShipDestroyed(shipIndex)
    ships[shipIndex] = nil

    -- if they're all destroyed, the event ends
    if tablelength(ships) == 0 then
        terminate()
    end
end


function createShip(faction)
    local position = getPositionInSector()
    local volume = Balancing_GetSectorShipVolume(faction:getHomeSectorCoordinates()) * 5
    local ship = ShipGenerator.createShip(faction, position, volume)

    ship:title("Epic Mission Agent")
    ship:addScript("civilship.lua")
    ship:setValue("is_civil", 1)
    ship:registerCallback("onDestroyed", "onShipDestroyed")

    table.insert(ships, ship.index)
end

function getPositionInSector(maxDist)
    -- deliberately not [-1;1] to avoid round sectors
    -- see getUniformPositionInSector(maxDist) below
    local position = vec3(math.random(), math.random(), math.random());
    local dist = 0
    if maxDist == nil then
        dist = getFloat(-5000, 5000)
    else
        dist = getFloat(-maxDist, maxDist)
    end

    position = position * dist

    -- create a random up vector
    local up = vec3(math.random(), math.random(), math.random())

    -- create a random right vector
    local look = vec3(math.random(), math.random(), math.random())

    -- create the look vector from them
    local mat = MatrixLookUp(look, up)
    mat.pos = position

    return mat
end
