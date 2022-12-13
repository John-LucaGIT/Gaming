local blip = {}
local x,y,z = {}
local telenr = call ( getResourceFromName("vio"), "vioGetElementData", player, "telenr")
local caller = getPlayerName(player)
local faction = 0
blip[caller] = createBlip(x,y,z,0,3,0,0,255,255,0,99999,getRootElement())

function activateGPS(player,x,y,z,status,serviceText,actionChosen)
    if status == "L.A.P.D." then
        blip[caller](x,y,z)
        setElementVisibleTo(blip[caller],getRootElement(),false)
        setElementVisibleTo(blip[caller],vioGetElementData(playeritem,"fraktion") == 1,true)
    elseif status == "L.A. MEDIC" then
        blip[caller](x,y,z)
        setElementVisibleTo(blip[caller],getRootElement(),false)
        setElementVisibleTo(blip[caller],vioGetElementData(playeritem,"fraktion") == 10,true)
    elseif status == "L.A.F.D." then
        blip[caller](x,y,z)
        setElementVisibleTo(blip[caller],getRootElement(),false)
        setElementVisibleTo(blip[caller],vioGetElementData(playeritem,"fraktion") == 15,true)
    elseif status == "L.A. OAMT" then
        blip[caller](x,y,z)
        setElementVisibleTo(blip[caller],getRootElement(),false)
        setElementVisibleTo(blip[caller],vioGetElementData(playeritem,"fraktion") == 12,true)
    end
end
addEvent("notruf",true)
addEventHandler("notruf",getRootElement(),activateGPS)