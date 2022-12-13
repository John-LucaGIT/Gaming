---------Info----------
-- Author: John-Luca
-----------------------
function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if
        type( sEventName ) == 'string' and
        isElement( pElementAttachedTo ) and
        type( func ) == 'function'
    then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isCursorOnElement( posX, posY, width, height )
    if isCursorShowing( ) then
        local mouseX, mouseY = getCursorPosition( )
        local clientW, clientH = guiGetScreenSize( )
        local mouseX, mouseY = mouseX * clientW, mouseY * clientH
        if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
            return true
        end
    end
    return false
end

----------------------------------------------------------------------------------------------------------------------------------------

local screenW, screenH = guiGetScreenSize()
local autoscooterwindowOpen = false
local WindowSelected = 0
local JoinedPlayer = {
    {false,"Frei"},
    {false,"Frei"},
    {false,"Frei"},
    {false,"Frei"},
    {false,"Frei"},
    {false,"Frei"},
}
local bettingMoney = 0
local SelectedPlayerInList = 0
local SelectedPlayerColor = {
    {255,255,255},
    {255,255,255},
    {255,255,255},
    {255,255,255},
    {255,255,255},
    {255,255,255},
}
local erfolgsmeldung = ""
local lp = getLocalPlayer()
local playerName = getPlayerName(lp)

function SetSelectPlayerColor(select)
    select = tonumber(select)
    if not select then return end
    for i = 1, #SelectedPlayerColor do
        SelectedPlayerColor[i][1] = 255
        SelectedPlayerColor[i][2] = 255
        SelectedPlayerColor[i][3] = 255
    end
    SelectedPlayerColor[select][1] = 126
    SelectedPlayerColor[select][2] = 126
    SelectedPlayerColor[select][3] = 126
end

function scooterwindowopen()
	if autoscooterwindowOpen == false then
		autoscooterwindowOpen = true
		showCursor(true)
		addEventHandler("onClientRender",getRootElement(),drawautoscooterwindow)
		addEventHandler("onClientClick",getRootElement(),buttonClose)
	end
end
addEvent ("clickclick",true)
addEventHandler("clickclick",getRootElement(),scooterwindowopen)

function scooterwindowclose()
	if autoscooterwindowOpen == true then
        autoscooterwindowOpen = false
        WindowSelected = 0
		showCursor(false)
		removeEventHandler("onClientRender",getRootElement(),drawautoscooterwindow)
		removeEventHandler("onClientClick",getRootElement(),buttonClose)
		erfolgsmeldung = ""
		bettingMoney = 0
		selectedPlayerInList = 0
		for i = 1, #JoinedPlayer do
			JoinedPlayer[i][1] = false
			JoinedPlayer[i][2] = "Frei"
		end
		for i = 1, #SelectedPlayerColor do
			SelectedPlayerColor[i][1] = 255
			SelectedPlayerColor[i][2] = 255
			SelectedPlayerColor[i][3] = 255
		end
	end
end

function drawautoscooterwindow()
	-- Hintergrund --
    dxDrawLine((screenW * 0.3453) - 1, (screenH * 0.2509) - 1, (screenW * 0.3453) - 1, screenH * 0.6648, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine(screenW * 0.6589, (screenH * 0.2509) - 1, (screenW * 0.3453) - 1, (screenH * 0.2509) - 1, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine((screenW * 0.3453) - 1, screenH * 0.6648, screenW * 0.6589, screenH * 0.6648, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine(screenW * 0.6589, screenH * 0.6648, screenW * 0.6589, (screenH * 0.2509) - 1, tocolor(0, 126, 233, 255), 1, false)
    dxDrawRectangle(screenW * 0.3453, screenH * 0.2509, screenW * 0.3135, screenH * 0.4139, tocolor(0, 0, 0, 255), false)
	-- X Button --
    dxDrawLine((screenW * 0.6464) - 1, (screenH * 0.2509) - 1, (screenW * 0.6464) - 1, screenH * 0.2722, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine(screenW * 0.6589, (screenH * 0.2509) - 1, (screenW * 0.6464) - 1, (screenH * 0.2509) - 1, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine((screenW * 0.6464) - 1, screenH * 0.2722, screenW * 0.6589, screenH * 0.2722, tocolor(0, 126, 233, 255), 1, false)
    dxDrawLine(screenW * 0.6589, screenH * 0.2722, screenW * 0.6589, (screenH * 0.2509) - 1, tocolor(0, 126, 233, 255), 1, false)
    dxDrawRectangle(screenW * 0.6464, screenH * 0.2509, screenW * 0.0125, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
    dxDrawText("X", screenW * 0.6469, screenH * 0.2509, screenW * 0.6589, screenH * 0.2722, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	-- Abtrennung --
	dxDrawLine(screenW * 0.6583, screenH * 0.2722, screenW * 0.3443, screenH * 0.2722, tocolor(0, 126, 233, 255), 1, false)
	-- Überschrift --
    dxDrawText("Autoscooter", screenW * 0.3453, screenH * 0.2509, screenW * 0.6464, screenH * 0.2722, tocolor(255, 255, 255, 255), 0.80, "bankgothic", "center", "center", false, false, false, false, false)
	-- Image --
    dxDrawImage(screenW * 0.4557, screenH * 0.4370, screenW * 0.0896, screenH * 0.1407, ":vio/autoscooterkaputt/Images/bumpercar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

    if WindowSelected == 0 then
    	-- Beitreten Button --
        dxDrawLine((screenW * 0.6010) - 1, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6536, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6010) - 1, screenH * 0.6556, screenW * 0.6536, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6536, screenH * 0.6556, screenW * 0.6536, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.6010, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Beitreten", screenW * 0.6010, screenH * 0.6333, screenW * 0.6536, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        -- Team Button --
        dxDrawLine((screenW * 0.5453) - 1, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5453) - 1, screenH * 0.6556, screenW * 0.5979, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, screenH * 0.6556, screenW * 0.5979, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5453, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Team", screenW * 0.5453, screenH * 0.6333, screenW * 0.5979, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Info --
        dxDrawText("Willkommen beim Autoscooter "..playerName..". \nHier kannst du aleine Spielen, oder mit Freunden Spielen und Wetten ablegen. \nDer Eintritt kostet 50$.", screenW * 0.3974, screenH * 0.2815, screenW * 0.6036, screenH * 0.4278, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
    if WindowSelected == 1 then
    	-- Team beitreten Button --
        dxDrawLine((screenW * 0.5453) - 1, (screenH * 0.6065) - 1, (screenW * 0.5453) - 1, screenH * 0.6287, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, (screenH * 0.6065) - 1, (screenW * 0.5453) - 1, (screenH * 0.6065) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5453) - 1, screenH * 0.6287, screenW * 0.5979, screenH * 0.6287, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, screenH * 0.6287, screenW * 0.5979, (screenH * 0.6065) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5453, screenH * 0.6065, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Team beitreten", screenW * 0.5453, screenH * 0.6065, screenW * 0.5979, screenH * 0.6287, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Team erstellen Button --
        dxDrawLine((screenW * 0.5453) - 1, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5453) - 1, screenH * 0.6556, screenW * 0.5979, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5979, screenH * 0.6556, screenW * 0.5979, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5453, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Team erstellen", screenW * 0.5453, screenH * 0.6333, screenW * 0.5979, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 1 Field --
        dxDrawText("Player 1", screenW * 0.3589, screenH * 0.2815, screenW * 0.4375, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3547) - 1, (screenH * 0.3009) - 1, (screenW * 0.3547) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4427, (screenH * 0.3009) - 1, (screenW * 0.3547) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3547) - 1, screenH * 0.3250, screenW * 0.4427, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4427, screenH * 0.3250, screenW * 0.4427, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3547, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[1][1], SelectedPlayerColor[1][2], SelectedPlayerColor[1][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[1][2]), screenW * 0.6570, screenH * 0.6039, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 2 Field --
        dxDrawText("Player 2", screenW * 0.4594, screenH * 0.2815, screenW * 0.5380, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4552) - 1, (screenH * 0.3009) - 1, (screenW * 0.4552) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5432, (screenH * 0.3009) - 1, (screenW * 0.4552) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.4552) - 1, screenH * 0.3250, screenW * 0.5432, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5432, screenH * 0.3250, screenW * 0.5432, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.4552, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[2][1], SelectedPlayerColor[2][2], SelectedPlayerColor[2][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[2][2]), screenW * 0.8397, screenH * 0.6039, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 3 Field --
        dxDrawText("Player 3", screenW * 0.5599, screenH * 0.2815, screenW * 0.6385, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.3009) - 1, (screenW * 0.5557) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, (screenH * 0.3009) - 1, (screenW * 0.5557) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5557) - 1, screenH * 0.3250, screenW * 0.6438, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, screenH * 0.3250, screenW * 0.6438, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5557, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[3][1], SelectedPlayerColor[3][2], SelectedPlayerColor[3][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[3][2]), screenW * 1.0400, screenH * 0.6039, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 4 Field --
        dxDrawText("Player 4", screenW * 0.3589, screenH * 0.3454, screenW * 0.4375, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3547) - 1, (screenH * 0.3704) - 1, (screenW * 0.3547) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4427, (screenH * 0.3704) - 1, (screenW * 0.3547) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3547) - 1, screenH * 0.3944, screenW * 0.4427, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4427, screenH * 0.3944, screenW * 0.4427, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3547, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[4][1], SelectedPlayerColor[4][2], SelectedPlayerColor[4][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[4][2]), screenW * 0.6400, screenH * 0.7434, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 5  Field --
        dxDrawText("Player 5", screenW * 0.4594, screenH * 0.3454, screenW * 0.5380, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4552) - 1, (screenH * 0.3704) - 1, (screenW * 0.4552) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5432, (screenH * 0.3704) - 1, (screenW * 0.4552) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.4552) - 1, screenH * 0.3944, screenW * 0.5432, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5432, screenH * 0.3944, screenW * 0.5432, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.4552, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[5][1], SelectedPlayerColor[5][2], SelectedPlayerColor[5][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[5][2]), screenW * 0.8393, screenH * 0.7434, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Player 6  Field --
        dxDrawText("Player 6", screenW * 0.5578, screenH * 0.3454, screenW * 0.6365, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.3704) - 1, (screenW * 0.5557) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, (screenH * 0.3704) - 1, (screenW * 0.5557) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5557) - 1, screenH * 0.3944, screenW * 0.6438, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, screenH * 0.3944, screenW * 0.6438, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5557, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(SelectedPlayerColor[6][1], SelectedPlayerColor[6][2], SelectedPlayerColor[6][3], 255), false)
        dxDrawText(""..tostring(JoinedPlayer[6][2]), screenW * 1.0400, screenH * 0.7434, screenW * 0.0880, screenH * 0.0241, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Start button --
        dxDrawLine((screenW * 0.6010) - 1, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6536, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6010) - 1, screenH * 0.6556, screenW * 0.6536, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6536, screenH * 0.6556, screenW * 0.6536, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.6010, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Start", screenW * 0.6010, screenH * 0.6343, screenW * 0.6536, screenH * 0.6565, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Money field --
        dxDrawRectangle(screenW * 0.5557, screenH * 0.4426, screenW * 0.0531, screenH * 0.0213, tocolor(255, 255, 255, 255), false)
        dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.4426) - 1, (screenW * 0.5557) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6089, (screenH * 0.4426) - 1, (screenW * 0.5557) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5557) - 1, screenH * 0.4639, screenW * 0.6089, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6089, screenH * 0.4639, screenW * 0.6089, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
		dxDrawText(""..tostring(bettingMoney).."$",screenW * 1.09, screenH * 0.8846, screenW * 0.0531, screenH * 0.0213, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- - button --
        dxDrawRectangle(screenW * 0.6141, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("-", screenW * 0.6141, screenH * 0.4426, screenW * 0.6266, screenH * 0.4639, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.6141) - 1, (screenH * 0.4426) - 1, (screenW * 0.6141) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6266, (screenH * 0.4426) - 1, (screenW * 0.6141) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6141) - 1, screenH * 0.4639, screenW * 0.6266, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6266, screenH * 0.4639, screenW * 0.6266, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)

        -- + button --
        dxDrawRectangle(screenW * 0.6312, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawLine((screenW * 0.6312) - 1, (screenH * 0.4426) - 1, (screenW * 0.6312) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, (screenH * 0.4426) - 1, (screenW * 0.6312) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6312) - 1, screenH * 0.4639, screenW * 0.6438, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, screenH * 0.4639, screenW * 0.6438, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawText("+", screenW * 0.6312, screenH * 0.4426, screenW * 0.6438, screenH * 0.4639, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)

        -- Wette ablegen button --
        dxDrawRectangle(screenW * 0.5911, screenH * 0.4731, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
        dxDrawText("Wette ablegen", screenW * 0.5911, screenH * 0.4731, screenW * 0.6438, screenH * 0.4954, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.5911) - 1, (screenH * 0.4731) - 1, (screenW * 0.5911) - 1, screenH * 0.4954, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, (screenH * 0.4731) - 1, (screenW * 0.5911) - 1, (screenH * 0.4731) - 1, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5911) - 1, screenH * 0.4954, screenW * 0.6438, screenH * 0.4954, tocolor(0, 126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6438, screenH * 0.4954, screenW * 0.6438, (screenH * 0.4731) - 1, tocolor(0, 126, 233, 255), 1, false)

        -- Erfolgsmeldung 1 --
        dxDrawText("Team erstellt!", screenW * 0.4880, screenH * 0.6343, screenW * 0.5432, screenH * 0.6556, tocolor(17, 200, 47, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Erfolgsmeldung 2 --
        dxDrawText(""..erfolgsmeldung, screenW * 0.5339, screenH * 0.4741, screenW * 0.5891, screenH * 0.4954, tocolor(17, 200, 47, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Errormeldung 1 --
        dxDrawText("Du kannst nur mit 2 Spielern wetten!", screenW * 0.5302, screenH * 0.4176, screenW * 0.6438, screenH * 0.4426, tocolor(233, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
end

function buttonClose(button,state)
	if button == "left" then
		if state == "down" then
			if isCursorOnElement(screenW * 0.6464, screenH * 0.2509, screenW * 0.0125, screenH * 0.0213) then -- X Button (G)
				scooterwindowclose()
            elseif isCursorOnElement(screenW * 0.6010, screenH * 0.6333, screenW * 0.6536, screenH * 0.6556) then -- Beitreten Button (1)
                if WindowSelected == 0 then
					scooterwindowclose()
                    triggerServerEvent("reinda",lp,lp)
                end
            elseif isCursorOnElement(screenW * 0.5453, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222) then -- Team Button (1)
                if WindowSelected == 0 then
                    WindowSelected = 1
                end
			elseif isCursorOnElement(screenW * 0.5453, screenH * 0.6065, screenW * 0.0526, screenH * 0.0222) then -- Team Beitreten Button (2)
                if WindowSelected == 1 then
                    triggerServerEvent("sync",lp,lp,playerName)
                end
			elseif isCursorOnElement(screenW * 0.6312, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213) then -- + Button
				if WindowSelected == 1 then
					if bettingMoney < 20000 then
						bettingMoney = bettingMoney+1000
					end
                end
            elseif isCursorOnElement(screenW * 0.6141, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213) then -- - Button
                if WindowSelected == 1 then
                    if bettingMoney > 0 then
                        bettingMoney = bettingMoney-1000
                    end
                end
            elseif isCursorOnElement(screenW * 0.3547, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241) then -- Player1Select
                if WindowSelected == 1 then
                    if JoinedPlayer[1][1] == true then
                        SelectedPlayerInList = 1
                        SetSelectPlayerColor(1)
                    end
                end
            elseif isCursorOnElement(screenW * 0.4552, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241) then -- Player2Select
                if WindowSelected == 1 then
                    if JoinedPlayer[2][1] == true then
                        SelectedPlayerInList = 2
                        SetSelectPlayerColor(2)
                    end
                end
            elseif isCursorOnElement(screenW * 0.5557, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241) then -- Player3Select
                if WindowSelected == 1 then
                    if JoinedPlayer[3][1] == true then
                        SelectedPlayerInList = 3
                        SetSelectPlayerColor(3)
                    end
                end
            elseif isCursorOnElement(screenW * 0.3547, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241) then -- Player4Select
                if WindowSelected == 1 then
                    if JoinedPlayer[4][1] == true then
                        SelectedPlayerInList = 4
                        SetSelectPlayerColor(4)
                    end
                end
            elseif isCursorOnElement(screenW * 0.4552, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241) then -- Player5Select
                if WindowSelected == 1 then
                    if JoinedPlayer[5][1] == true then
                        SelectedPlayerInList = 5
                        SetSelectPlayerColor(5)
                    end
                end
            elseif isCursorOnElement(screenW * 0.5557, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241) then -- Player6Select
                if WindowSelected == 1 then
                    if JoinedPlayer[6][1] == true then
                        SelectedPlayerInList = 6
                        SetSelectPlayerColor(6)
                    end
                end
            elseif isCursorOnElement(screenW * 0.5911, screenH * 0.4731, screenW * 0.0526, screenH * 0.0222) then -- Bieten
                if WindowSelected == 1 then
                    if SelectedPlayerInList > 0  and SelectedPlayerInList < 7 then
                        triggerServerEvent("setPlayerBet",lp,lp,SelectedPlayerInList,bettingMoney)
						erfolgsmeldung = "Wette abgelegt!"
                    end
                end
			end
		end
	end
end

function tableSync(table)
	JoinedPlayer = table
end
addEvent("synctable",true)
addEventHandler("synctable",getRootElement(),tableSync)



