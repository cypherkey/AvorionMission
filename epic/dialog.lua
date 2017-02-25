package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("randomext")
require ("utility")
require ("stringutility")
Dialog = require ("dialogutility")

function initUI()
    ScriptUI():registerInteraction("Get mission"%_t, "onGetMission")
end

function initialize()
    local entity = Entity()

    if onClient() then
        InteractionText(entity.index).text = "Hello. I am the Epic Mission Agent."
    end
end

function interactionPossible(playerIndex, option)
    return true
end

function onGetMission()
    local dialog = {}
    dialog.text = string.format("Starting mission 1"%_t)
    dialog.onEnd = "restart"

    ScriptUI():showDialog(dialog)
end
