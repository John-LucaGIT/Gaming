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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local panelState = 0
local screenW, screenH = guiGetScreenSize()
local lp = getLocalPlayer()
local status = ""
local textfieldValue = ""
local actionChosen = ""
local memo = {}
local memocreated = false
local serviceText = guiGetText(memo)
local x,y,z
local serviceSent = false

function isGUIVisible()
    if memocreated == true and panelState == 2 then
        guiSetVisible(memo,false)
    elseif memocreated == true and panelState <= 1 then
        guiSetVisible(memo,true)
    end
end


function startServicePanel(player)
    gdim = getElementDimension(lp)
    if player then
        if gdim == 0 then
            if isEventHandlerAdded("onClientRender",getRootElement(),renderServicePanel) then
                stopServicePanel()
            else
                addEventHandler("onClientRender",getRootElement(),renderServicePanel)
                addEventHandler("onClientClick",getRootElement(),buttonStates)
                panelState = 1
                showCursor(true)
                serviceSent = false
            end
        end
    end
end
addCommandHandler("service",startServicePanel)

function stopServicePanel()
    if panelState > 0 then
        panelState = 0
        showCursor(false)
        removeEventHandler("onClientRender",getRootElement(),renderServicePanel)
        removeEventHandler("onClientClick",getRootElement(),buttonStates)
		if memocreated == true then
        destroyElement(memo)
        memocreated = false
		end
        status = ""
        actionChosen = ""
    end
end


function renderServicePanel()
        -- Hintergrund --
        dxDrawLine((screenW * 0.3443) - 1, (screenH * 0.3065) - 1, (screenW * 0.3443) - 1, screenH * 0.6806, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6719, (screenH * 0.3065) - 1, (screenW * 0.3443) - 1, (screenH * 0.3065) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3443) - 1, screenH * 0.6806, screenW * 0.6719, screenH * 0.6806, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6719, screenH * 0.6806, screenW * 0.6719, (screenH * 0.3065) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3443, screenH * 0.3065, screenW * 0.3276, screenH * 0.3741, tocolor(0, 0, 0, 255), false)
        dxDrawText("SERVICE PANEL", screenW * 0.4141, screenH * 0.3074, screenW * 0.6042, screenH * 0.3306, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)

        -- X Button --
        dxDrawLine(screenW * 0.3443, screenH * 0.3315, screenW * 0.6714, screenH * 0.3306, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6573) - 1, (screenH * 0.3065) - 1, (screenW * 0.6573) - 1, screenH * 0.3306, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6719, (screenH * 0.3065) - 1, (screenW * 0.6573) - 1, (screenH * 0.3065) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.6573) - 1, screenH * 0.3306, screenW * 0.6719, screenH * 0.3306, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6719, screenH * 0.3306, screenW * 0.6719, (screenH * 0.3065) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.6573, screenH * 0.3065, screenW * 0.0146, screenH * 0.0241, tocolor(67, 67, 67, 255), false)
        dxDrawText("X", screenW * 0.6568, screenH * 0.3074, screenW * 0.6714, screenH * 0.3306, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)

        -- L.A.P.D. Button --
        dxDrawLine((screenW * 0.3854) - 1, (screenH * 0.3546) - 1, (screenW * 0.3854) - 1, screenH * 0.4019, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4781, (screenH * 0.3546) - 1, (screenW * 0.3854) - 1, (screenH * 0.3546) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3854) - 1, screenH * 0.4019, screenW * 0.4781, screenH * 0.4019, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4781, screenH * 0.4019, screenW * 0.4781, (screenH * 0.3546) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3854, screenH * 0.3546, screenW * 0.0927, screenH * 0.0472, tocolor(67, 67, 67, 255), false)
        dxDrawText("L.A.P.D.", screenW * 0.3849, screenH * 0.3546, screenW * 0.4781, screenH * 0.4019, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)

        -- L.A. Medic Button --
        dxDrawLine((screenW * 0.5385) - 1, (screenH * 0.3546) - 1, (screenW * 0.5385) - 1, screenH * 0.4019, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6312, (screenH * 0.3546) - 1, (screenW * 0.5385) - 1, (screenH * 0.3546) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5385) - 1, screenH * 0.4019, screenW * 0.6312, screenH * 0.4019, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6312, screenH * 0.4019, screenW * 0.6312, (screenH * 0.3546) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5385, screenH * 0.3546, screenW * 0.0927, screenH * 0.0472, tocolor(67, 67, 67, 255), false)
        dxDrawText("L.A. MEDIC", screenW * 0.5385, screenH * 0.3546, screenW * 0.6318, screenH * 0.4019, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)

        -- L.A.F.D. Button --
        dxDrawLine((screenW * 0.3854) - 1, (screenH * 0.4204) - 1, (screenW * 0.3854) - 1, screenH * 0.4676, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4781, (screenH * 0.4204) - 1, (screenW * 0.3854) - 1, (screenH * 0.4204) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3854) - 1, screenH * 0.4676, screenW * 0.4781, screenH * 0.4676, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4781, screenH * 0.4676, screenW * 0.4781, (screenH * 0.4204) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3854, screenH * 0.4204, screenW * 0.0927, screenH * 0.0472, tocolor(67, 67, 67, 255), false)
        dxDrawText("L.A.F.D.", screenW * 0.3849, screenH * 0.4204, screenW * 0.4781, screenH * 0.4676, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)

        -- L.A. OAMT Button --
        dxDrawLine((screenW * 0.5385) - 1, (screenH * 0.4204) - 1, (screenW * 0.5385) - 1, screenH * 0.4676, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6312, (screenH * 0.4204) - 1, (screenW * 0.5385) - 1, (screenH * 0.4204) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5385) - 1, screenH * 0.4676, screenW * 0.6312, screenH * 0.4676, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6312, screenH * 0.4676, screenW * 0.6312, (screenH * 0.4204) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5385, screenH * 0.4204, screenW * 0.0927, screenH * 0.0472, tocolor(67, 67, 67, 255), false)
        dxDrawText("L.A. OAMT", screenW * 0.5385, screenH * 0.4204, screenW * 0.6318, screenH * 0.4676, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Text Field --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.4880) - 1, (screenW * 0.3844) - 1, screenH * 0.6324, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.4880) - 1, (screenW * 0.3844) - 1, (screenH * 0.4880) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.6324, screenW * 0.6318, screenH * 0.6324, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.6324, screenW * 0.6318, (screenH * 0.4880) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.5340, screenW * 0.2474, screenH * 0.0988, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..tostring(textfieldValue), screenW * 0.3839, screenH * 0.5324, screenW * 0.6318, screenH * 0.6324, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)

        -- Selected Service Indicator --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.4880) - 1, (screenW * 0.3844) - 1, screenH * 0.5093, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.4880) - 1, (screenW * 0.3844) - 1, (screenH * 0.4880) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.5093, screenW * 0.6318, screenH * 0.5093, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.5093, screenW * 0.6318, (screenH * 0.4880) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.4880, screenW * 0.2474, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("SELECTED SERVICE: "..tostring(status), screenW * 0.3849, screenH * 0.4880, screenW * 0.6328, screenH * 0.5093, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Service Select Dropdown --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.5111) - 1, (screenW * 0.3844) - 1, screenH * 0.5324, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.5111) - 1, (screenW * 0.3844) - 1, (screenH * 0.5111) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.5324, screenW * 0.6318, screenH * 0.5324, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.5324, screenW * 0.6318, (screenH * 0.5111) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.5111, screenW * 0.2474, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("SELECTED SERVICE ACTION: "..tostring(actionChosen), screenW * 0.3839, screenH * 0.5111, screenW * 0.6318, screenH * 0.5324, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Notruf Button --
        dxDrawLine((screenW * 0.5443) - 1, (screenH * 0.6380) - 1, (screenW * 0.5443) - 1, screenH * 0.6713, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.6380) - 1, (screenW * 0.5443) - 1, (screenH * 0.6380) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5443) - 1, screenH * 0.6713, screenW * 0.6318, screenH * 0.6713, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.6713, screenW * 0.6318, (screenH * 0.6380) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5443, screenH * 0.6380, screenW * 0.0875, screenH * 0.0333, tocolor(67, 67, 67, 255), false)
        dxDrawText("NOTRUF ABSCHICKEN", screenW * 0.5443, screenH * 0.6398, screenW * 0.6318, screenH * 0.6713, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    if panelState == 2 then
        -- Hintergrund Dropdown --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.5324) - 1, (screenW * 0.3844) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.5324) - 1, (screenW * 0.3844) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.5537, screenW * 0.6318, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.5537, screenW * 0.6318, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.5324, screenW * 0.2474, screenH * 0.0213, tocolor(67, 67, 67, 255), false)

        -- Auto Button --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.5324) - 1, (screenW * 0.3844) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4307, (screenH * 0.5324) - 1, (screenW * 0.3844) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.5537, screenW * 0.4307, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4307, screenH * 0.5537, screenW * 0.4307, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("Auto", screenW * 0.3839, screenH * 0.5315, screenW * 0.4307, screenH * 0.5537, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Mottorad Button --
        dxDrawLine((screenW * 0.4307) - 1, (screenH * 0.5324) - 1, (screenW * 0.4307) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4771, (screenH * 0.5324) - 1, (screenW * 0.4307) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.4307) - 1, screenH * 0.5537, screenW * 0.4771, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.4771, screenH * 0.5537, screenW * 0.4771, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.4307, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("Mottorad", screenW * 0.4302, screenH * 0.5324, screenW * 0.4771, screenH * 0.5546, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- LKW / Bus Button --
        dxDrawLine((screenW * 0.4771) - 1, (screenH * 0.5324) - 1, (screenW * 0.4771) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5234, (screenH * 0.5324) - 1, (screenW * 0.4771) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.4771) - 1, screenH * 0.5537, screenW * 0.5234, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5234, screenH * 0.5537, screenW * 0.5234, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.4771, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("LKW / Bus", screenW * 0.4766, screenH * 0.5324, screenW * 0.5234, screenH * 0.5546, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Boot Button --
        dxDrawLine((screenW * 0.5234) - 1, (screenH * 0.5324) - 1, (screenW * 0.5234) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5698, (screenH * 0.5324) - 1, (screenW * 0.5234) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5234) - 1, screenH * 0.5537, screenW * 0.5698, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.5698, screenH * 0.5537, screenW * 0.5698, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5234, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("Boot", screenW * 0.5229, screenH * 0.5324, screenW * 0.5698, screenH * 0.5546, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Flugobjekt Button --
        dxDrawLine((screenW * 0.5698) - 1, (screenH * 0.5324) - 1, (screenW * 0.5698) - 1, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.5324) - 1, (screenW * 0.5698) - 1, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.5698) - 1, screenH * 0.5537, screenW * 0.6318, screenH * 0.5537, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.5537, screenW * 0.6318, (screenH * 0.5324) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.5698, screenH * 0.5324, screenW * 0.0620, screenH * 0.0213, tocolor(67, 67, 67, 255), false)
        dxDrawText("Flugobjekt", screenW * 0.5698, screenH * 0.5324, screenW * 0.6318, screenH * 0.5537, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

        -- Drogenfund Button --
        dxDrawLine((screenW * 0.3844) - 1, (screenH * 0.5537) - 1, (screenW * 0.3844) - 1, screenH * 0.5731, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, (screenH * 0.5537) - 1, (screenW * 0.3844) - 1, (screenH * 0.5537) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine((screenW * 0.3844) - 1, screenH * 0.5731, screenW * 0.6318, screenH * 0.5731, tocolor(0,126, 233, 255), 1, false)
        dxDrawLine(screenW * 0.6318, screenH * 0.5731, screenW * 0.6318, (screenH * 0.5537) - 1, tocolor(0,126, 233, 255), 1, false)
        dxDrawRectangle(screenW * 0.3844, screenH * 0.5537, screenW * 0.2474, screenH * 0.0194, tocolor(67, 67, 67, 255), false)
        dxDrawText("Drogenfund", screenW * 0.3844, screenH * 0.5556, screenW * 0.6323, screenH * 0.5731, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
end


function buttonStates(button,state)
    if button == "left" and state == "down" then
        if isCursorOnElement(screenW * 0.6573, screenH * 0.3065, screenW * 0.0146, screenH * 0.0241) and panelState > 0 then -- X Button
            stopServicePanel()
        elseif isCursorOnElement(screenW * 0.3854, screenH * 0.3546, screenW * 0.0927, screenH * 0.0472) and panelState > 0 then -- L.A.P.D. Button
            status = "L.A.P.D."
        elseif isCursorOnElement(screenW * 0.5385, screenH * 0.3546, screenW * 0.0927, screenH * 0.0472) and panelState > 0 then -- L.A. Medic Button
            status = "L.A. MEDIC"
        elseif isCursorOnElement(screenW * 0.3854, screenH * 0.4204, screenW * 0.0927, screenH * 0.0472) and panelState > 0 then -- L.A.F.D. Button
            status = "L.A.F.D."
        elseif isCursorOnElement(screenW * 0.5385, screenH * 0.4204, screenW * 0.0927, screenH * 0.0472) and panelState > 0 then -- L.A. Oamt Button
            status = "L.A. OAMT"
        elseif isCursorOnElement(screenW * 0.3844, screenH * 0.5111, screenW * 0.2474, screenH * 0.0213) and panelState > 0 then -- Service Action
            if panelState == 1 then
                    panelState = 2
                    isGUIVisible()
            elseif panelState == 2 then
                    panelState = 1
                    isGUIVisible()
            end
        elseif isCursorOnElement(screenW * 0.3844, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213) and panelState == 2 then -- Auto Button
            actionChosen = "AUTO"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.4307, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213) and panelState == 2 then -- Mottorad Button
            actionChosen = "MOTTORAD"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.4771, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213) and panelState == 2 then -- LKW / Bus Button
            actionChosen = "LKW / BUS"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.5234, screenH * 0.5324, screenW * 0.0464, screenH * 0.0213) and panelState == 2 then -- Boot Button
            actionChosen = "BOOT"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.5698, screenH * 0.5324, screenW * 0.0620, screenH * 0.0213) and panelState == 2 then -- Flugobjekt Button
            actionChosen = "FLUGOBJEKT"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.3844, screenH * 0.5537, screenW * 0.2474, screenH * 0.0194) and panelState == 2 then -- Drogenfund Button
            actionChosen = "DROGENFUND"
            panelState = 1
            isGUIVisible()
        elseif isCursorOnElement(screenW * 0.3844, screenH * 0.5340, screenW * 0.2474, screenH * 0.0988) and panelState == 1 then -- Textfield
            if panelState < 2 and memocreated == false then
               memo = guiCreateMemo(0.384, 0.533, 0.248, 0.10, "", true)
               memocreated = true
            end
        elseif isCursorOnElement(screenW * 0.5443, screenH * 0.6380, screenW * 0.0875, screenH * 0.0333) and panelState > 0 then -- Absenden
            if status == "" then
                outputChatBox("Du hast keinen Notdienst ausgewählt!",255,0,0)
            elseif status == "L.A. OAMT" and actionChosen == "" then
                    outputChatBox("Bitte gebe einen Fahrzeugtyp an!",255,0,0)
            elseif status ~= "L.A.P.D." and actionChosen == "DROGENFUND" then
                    outputChatBox("Bitte wähle zuerst den Notdienst: L.A.P.D. aus!",255,0,0)
            elseif status ~= "L.A. OAMT" and actionChosen ~= "" and actionChosen ~= "DROGENFUND" then
                    outputChatBox("Fahrzeugtyppen sind nur für das L.A. OAMT relevant.",255,0,0)
            else
                outputChatBox("Bleibe dort wo du bist Hilfe ist unterwegs! Ausgewählter Service: "..tostring(status).." "..tostring(actionChosen),9,176,48)
				serviceNachricht()
                serviceSent = true
                stopServicePanel()
                x,y,z = getElementPosition(lp)
				showGPS()
            end
        end
    end
end

function serviceNachricht()
	if memocreated == true then
		outputChatBox(" Notruf Nachricht: "..tostring(guiGetText(memo)),9,176,48)
	end
end


function showGPS()
    if status ~= "" and serviceSent == true then
        triggerServerEvent("notruf",lp,lp,x,y,z,status,serviceText,actionChosen)
    end
end