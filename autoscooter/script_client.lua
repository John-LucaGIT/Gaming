----------------------Info---------------------
-- Author: John-Luca -  All rights reserved
-----------------------------------------------

local screenW, screenH = guiGetScreenSize()
local autoscooterwindowOpen = false
local secondwindowOpen = false
local firstwindowOpen = false
local lp = getLocalPlayer()

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

function scooterwindowopen()
	if autoscooterwindowOpen == false or firstwindowOpen == false then
		autoscooterwindowOpen = true
		firstwindowOpen = true
		showCursor(true)
		addEventHandler("onClientRender",getRootElement(),drawautoscooterwindow)
		addEventHandler("onClientRender",getRootElement(),drawautoscooterwindow1)
		addEventHandler("onClientClick",getRootElement(),buttonClose)
	end
end
addEvent ("clickclick",true)
addEventHandler("clickclick",getRootElement(),scooterwindowopen)

function firstwindowActive()
	if firstwindowOpen == false then
		firstwindowOpen = true
		addEventHandler("onClientRender",getRootElement(),drawautoscooterwindow1)
	end
end

-- function secondwindowActive()
	-- if secondwindowOpen == false then
		-- secondwindowOpen = true
		-- addEventHandler("onClientRender",getRootElement(),drawautoscooterwindow2)
	-- end
-- end


function scooterwindowclose()
	if autoscooterwindowOpen == true or firstwindowOpen == true or secondwindowOpen == true then
		autoscooterwindowOpen = false
		firstwindowOpen = false
		secondwindowOpen = false
		showCursor(false)
		removeEventHandler("onClientRender",getRootElement(),drawautoscooterwindow)
		removeEventHandler("onClientRender",getRootElement(),drawautoscooterwindow1)
		removeEventHandler("onClientClick",getRootElement(),buttonClose)
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
end

function drawautoscooterwindow1()
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
    dxDrawText("Coming Soon", screenW * 0.5453, screenH * 0.6333, screenW * 0.5979, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Info --
	dxDrawText("Willkommen beim Autoscooter. \nHier kannst du alleine Spielen, oder mit Freunden Spielen und Wetten ablegen. \nDer Eintritt kostet 50$.", screenW * 0.3974, screenH * 0.2815, screenW * 0.6036, screenH * 0.4278, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

-- function drawautoscooterwindow2()
	-- Team beitreten Button --
    -- dxDrawLine((screenW * 0.5453) - 1, (screenH * 0.6065) - 1, (screenW * 0.5453) - 1, screenH * 0.6287, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5979, (screenH * 0.6065) - 1, (screenW * 0.5453) - 1, (screenH * 0.6065) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5453) - 1, screenH * 0.6287, screenW * 0.5979, screenH * 0.6287, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5979, screenH * 0.6287, screenW * 0.5979, (screenH * 0.6065) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.5453, screenH * 0.6065, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
    -- dxDrawText("Team beitreten", screenW * 0.5453, screenH * 0.6065, screenW * 0.5979, screenH * 0.6287, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Team erstellen Button --
	-- dxDrawLine((screenW * 0.5453) - 1, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5979, (screenH * 0.6333) - 1, (screenW * 0.5453) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5453) - 1, screenH * 0.6556, screenW * 0.5979, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5979, screenH * 0.6556, screenW * 0.5979, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.5453, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
    -- dxDrawText("Team erstellen", screenW * 0.5453, screenH * 0.6333, screenW * 0.5979, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Player 1 Field --
    -- dxDrawText("Player 1", screenW * 0.3589, screenH * 0.2815, screenW * 0.4375, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.3547) - 1, (screenH * 0.3009) - 1, (screenW * 0.3547) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.4427, (screenH * 0.3009) - 1, (screenW * 0.3547) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.3547) - 1, screenH * 0.3250, screenW * 0.4427, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.4427, screenH * 0.3250, screenW * 0.4427, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
	-- dxDrawRectangle(screenW * 0.3547, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

	-- Player 2 Field --
    -- dxDrawText("Player 2", screenW * 0.4594, screenH * 0.2815, screenW * 0.5380, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.4552) - 1, (screenH * 0.3009) - 1, (screenW * 0.4552) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5432, (screenH * 0.3009) - 1, (screenW * 0.4552) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.4552) - 1, screenH * 0.3250, screenW * 0.5432, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5432, screenH * 0.3250, screenW * 0.5432, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.4552, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

	-- Player 3 Field --
    -- dxDrawText("Player 3", screenW * 0.5599, screenH * 0.2815, screenW * 0.6385, screenH * 0.2972, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    -- dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.3009) - 1, (screenW * 0.5557) - 1, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, (screenH * 0.3009) - 1, (screenW * 0.5557) - 1, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5557) - 1, screenH * 0.3250, screenW * 0.6438, screenH * 0.3250, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, screenH * 0.3250, screenW * 0.6438, (screenH * 0.3009) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.5557, screenH * 0.3009, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

	-- Player 4 Field --
    -- dxDrawText("Player 4", screenW * 0.3589, screenH * 0.3454, screenW * 0.4375, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.3547) - 1, (screenH * 0.3704) - 1, (screenW * 0.3547) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.4427, (screenH * 0.3704) - 1, (screenW * 0.3547) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.3547) - 1, screenH * 0.3944, screenW * 0.4427, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.4427, screenH * 0.3944, screenW * 0.4427, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.3547, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

    --  Player 5  Field --
    -- dxDrawText("Player 5", screenW * 0.4594, screenH * 0.3454, screenW * 0.5380, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.4552) - 1, (screenH * 0.3704) - 1, (screenW * 0.4552) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5432, (screenH * 0.3704) - 1, (screenW * 0.4552) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.4552) - 1, screenH * 0.3944, screenW * 0.5432, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.5432, screenH * 0.3944, screenW * 0.5432, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.4552, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

	-- Player 6  Field --
    -- dxDrawText("Player 6", screenW * 0.5578, screenH * 0.3454, screenW * 0.6365, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    -- dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.3704) - 1, (screenW * 0.5557) - 1, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, (screenH * 0.3704) - 1, (screenW * 0.5557) - 1, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5557) - 1, screenH * 0.3944, screenW * 0.6438, screenH * 0.3944, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, screenH * 0.3944, screenW * 0.6438, (screenH * 0.3704) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.5557, screenH * 0.3704, screenW * 0.0880, screenH * 0.0241, tocolor(255, 255, 255, 255), false)

	-- Start button --
    -- dxDrawLine((screenW * 0.6010) - 1, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6536, (screenH * 0.6333) - 1, (screenW * 0.6010) - 1, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.6010) - 1, screenH * 0.6556, screenW * 0.6536, screenH * 0.6556, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6536, screenH * 0.6556, screenW * 0.6536, (screenH * 0.6333) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawRectangle(screenW * 0.6010, screenH * 0.6333, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
	-- dxDrawText("Start", screenW * 0.6010, screenH * 0.6343, screenW * 0.6536, screenH * 0.6565, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Money field --
    -- dxDrawRectangle(screenW * 0.5557, screenH * 0.4426, screenW * 0.0531, screenH * 0.0213, tocolor(255, 255, 255, 255), false)
	-- dxDrawLine((screenW * 0.5557) - 1, (screenH * 0.4426) - 1, (screenW * 0.5557) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6089, (screenH * 0.4426) - 1, (screenW * 0.5557) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5557) - 1, screenH * 0.4639, screenW * 0.6089, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6089, screenH * 0.4639, screenW * 0.6089, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)

    -- button --
	-- dxDrawRectangle(screenW * 0.6141, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
    -- dxDrawText("-", screenW * 0.6141, screenH * 0.4426, screenW * 0.6266, screenH * 0.4639, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.6141) - 1, (screenH * 0.4426) - 1, (screenW * 0.6141) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6266, (screenH * 0.4426) - 1, (screenW * 0.6141) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.6141) - 1, screenH * 0.4639, screenW * 0.6266, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6266, screenH * 0.4639, screenW * 0.6266, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)

	-- + button --
	-- dxDrawRectangle(screenW * 0.6312, screenH * 0.4426, screenW * 0.0125, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
	-- dxDrawLine((screenW * 0.6312) - 1, (screenH * 0.4426) - 1, (screenW * 0.6312) - 1, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, (screenH * 0.4426) - 1, (screenW * 0.6312) - 1, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.6312) - 1, screenH * 0.4639, screenW * 0.6438, screenH * 0.4639, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, screenH * 0.4639, screenW * 0.6438, (screenH * 0.4426) - 1, tocolor(0, 126, 233, 255), 1, false)
	-- dxDrawText("+", screenW * 0.6312, screenH * 0.4426, screenW * 0.6438, screenH * 0.4639, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)

	-- Wette ablegen button --
    -- dxDrawRectangle(screenW * 0.5911, screenH * 0.4731, screenW * 0.0526, screenH * 0.0222, tocolor(67, 67, 67, 255), false)
    -- dxDrawText("Wette ablegen", screenW * 0.5911, screenH * 0.4731, screenW * 0.6438, screenH * 0.4954, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- dxDrawLine((screenW * 0.5911) - 1, (screenH * 0.4731) - 1, (screenW * 0.5911) - 1, screenH * 0.4954, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, (screenH * 0.4731) - 1, (screenW * 0.5911) - 1, (screenH * 0.4731) - 1, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine((screenW * 0.5911) - 1, screenH * 0.4954, screenW * 0.6438, screenH * 0.4954, tocolor(0, 126, 233, 255), 1, false)
    -- dxDrawLine(screenW * 0.6438, screenH * 0.4954, screenW * 0.6438, (screenH * 0.4731) - 1, tocolor(0, 126, 233, 255), 1, false)

	-- Erfolgsmeldung 1 --
    -- dxDrawText("Team erstellt!", screenW * 0.4880, screenH * 0.6343, screenW * 0.5432, screenH * 0.6556, tocolor(17, 200, 47, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Erfolgsmeldung 2 --
    -- dxDrawText("Wette abgelegt!", screenW * 0.5339, screenH * 0.4741, screenW * 0.5891, screenH * 0.4954, tocolor(17, 200, 47, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	-- Errormeldung 1 --
    -- dxDrawText("Du kannst nur mit 2 Spielern wetten!", screenW * 0.5302, screenH * 0.4176, screenW * 0.6438, screenH * 0.4426, tocolor(233, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
-- end

function buttonClose(button,state)
	if button == "left" then
		if state == "down" then
			if isCursorOnElement(screenW * 0.6464, screenH * 0.2509, screenW * 0.0125, screenH * 0.0213) then -- X Button
				scooterwindowclose()
			elseif isCursorOnElement(screenW * 0.6010, screenH * 0.6333, screenW * 0.6536, screenH * 0.6556) then -- Beitreten Button then
				scooterwindowclose()
				triggerServerEvent("reinda",lp,lp)
			end
		end
	end
end




