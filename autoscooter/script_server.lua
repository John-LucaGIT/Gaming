----------------------Info---------------------
-- Author: John-Luca -  All rights reserved
-----------------------------------------------

local pedderby = createPed(37,-1715.6298828125,134.529296875,3.5546875,90)
setElementFrozen (pedderby,true)

---------------------------------------Random ColShapes ---------------------------------------

rc1 = createColCuboid ( -1711.0933837891,204.24356079102,1,10.4,9.7,5)
rc2 = createColCuboid ( -1698.3857421875,162.11332702637,1,10.6,4.7,5)
rc3 = createColCuboid ( -1689.4697265625,181.3115234375,1,9.8,10.5,5)

local randocol = {rc1,rc2,rc3}

-----------------------------------------------------------------------------------------------------

----------------------------------------Perma ColShapes ----------------------------------------

local col
local col2
local col3

col = createColCuboid (-1714.390625,110,1,39,135.4,5)
col2 = createColCuboid (-1700.6320800781,235.65,1,10.5,9.5,5)
col3 = createColCuboid (-1704.7607421875,111.15625,1,18,10,5)
-----------------------------------------------------------------------------------------------------
local mID = 18244

local objectCoordinates = {
	{
		{-1711.4000244141,206.60000610352,-0.12600000202656,90,0,90},
		{-1711.4000244141,211.67999267578,-0.12600000202656,90,0,90},
		{-1708.4499511719,214.24499511719,-0.12300000339746,90,0,0},
		{-1703.3399658203,214.25,-0.12600000202656,90,0,0},
		{-1700.8000488281,211.69999694824,-0.12600000202656,90,0,90},
		{-1700.8000488281,206.60000610352,-0.12600000202656,90,0,90},
		{-1703.3599853516,204.44999694824,-0.12600000202656,90,0,0},
		{-1708.4630126953,204.44999694824,-0.12600000202656,90,0,0},
	},
	{
		{-1695.5999755859,167,-0.12600000202656,90,0,0},
		{-1690.5,167,-0.12600000202656,90,0,0},
		{-1687.9439697266,164.44999694824,-0.12600000202656,90,0,90},
		{-1690.5,162.30000305176,-0.12600000202656,90,0,0},
		{-1695.5999755859,162.30000305176,-0.12600000202656,90,0,0},
		{-1698.5400390625,164.46000671387,-0.12600000202656,90,0,90},
	},
	{
		{-1689.7399902344,184.05000305176,-0.12600000202656,90,0,90},
		{-1689.7399902344,189.14999389648,-0.12600000202656,90,0,90},
		{-1687.1999511719,192.10000610352,-0.12600000202656,90,0,0},
		{-1682.0999755859,192.10000610352,-0.12600000202656,90,0,0},
		{-1679.9399414063,184.05000305176,-0.12600000202656,90,0,90},
		{-1679.9399414063,189.14999389648,-0.12600000202656,90,0,90},
		{-1682.0999755859,181.5,-0.12600000202656,90,0,0},
		{-1687.1999511719,181.5,-0.12600000202656,90,0,0},
	},
}


local scooter = {}
local scootercolor = {
    {255,87,51,54,255,0},
    {54,255,0,255,87,51},
    {0,249,255,54,255,0},
    {246,0,255,0,249,255},
}
local team = {
	{-1679,114.59999847412,2.5,0,0,0.65933227539062,255,87,51},
	{-1707.6796875,240.5009765625,2.5,0,0,180.08792114258,246,0,255},
}



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

local dbx = 0
timeractive = false

function ChangeChallanges()
	if timeractive == false then
		setTimer(function() -- gibt die Zeit an in der die unteren funktionen aktiviert werden sollen und wie oft 0 = wiederholt
		timeractive = true
			if isEventHandlerAdded("onColShapeHit",randocol[dbx],killzone) then -- fragt ab ob bereits ein eventhandler "oncolshapehit ..." vorhanden ist
				removeEventHandler("onColShapeHit",randocol[dbx],killzone) -- removed den eventhandler wenn einer bereits vorhanden ist
			end
			dbx = math.random(#randocol) -- generiert eine random zahl von der tabelle randocol (1-3) und speichert diese in dbx
			ChangeObject()
			addEventHandler("onColShapeHit",randocol[dbx],killzone) -- fügt einen eventhandler hinzu
		end,15000,0) -- beendet timer
	end
end -- beendet changechallanges

local objects = {}

function ChangeObject()
	for i = 1, #objects do
		if objects[i] and isElement (objects[i]) then
		destroyElement(objects[i])
		end
	end
	if dbx == 0 then
		dbx = 1
	end
	for i = 1, #objectCoordinates[dbx] do
		objects[i] = createObject(mID,objectCoordinates[dbx][i][1],objectCoordinates[dbx][i][2],objectCoordinates[dbx][i][3],objectCoordinates[dbx][i][4],objectCoordinates[dbx][i][5],objectCoordinates[dbx][i][6])
	end
end

function mapend (Element,Dim,Player)
    if Element and Dim then
        if getElementType ( Element ) == "vehicle" then
            if getVehicleOccupant(Element) then
                local Player = getVehicleOccupant(Element)
				if scooter[getPlayerName(Player)] == Element then
					destroyElement(scooter[getPlayerName(Player)])
					scooter[getPlayerName(Player)] = nil
					outputChatBox("Du hast das Spielfeld Verlassen!",Player,255,0,0)
                end
            end
        end
    end
end
addEventHandler("onColShapeLeave",col,mapend)

function killzone (Element,Dim)
    if Element and Dim then
        if getElementType ( Element ) == "vehicle" then
            if getVehicleOccupant(Element) then
                local Player = getVehicleOccupant(Element)
				if scooter[getPlayerName(Player)] == Element then
					destroyElement(scooter[getPlayerName(Player)])
					scooter[getPlayerName(Player)] = nil
					setTimer(function()
						setElementPosition(Player,-1717.3046875,134.5986328125,3.5546875)
						setElementRotation(player,0,0,268.26550292969)
					end,1000,1)
					outputChatBox("Du wurdest eliminiert!",Player,255,0,0)
                end
            end
        end
    end
end
addEventHandler("onColShapeHit",col2,killzone)
addEventHandler("onColShapeHit",col3,killzone)


function drawautoscooterwindow (button,state,clickedElement)
	if button == "left" and state == "down" then
		px,py,pz = getElementPosition(source)
		vx,vy,vz = getElementPosition(pedderby)
		if getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz) < 5 then
			if clickedElement == pedderby then
			triggerClientEvent (source,"clickclick",source)
			end
		end
	end
end
addEventHandler ("onPlayerClick",getRootElement(),drawautoscooterwindow)

function enterscooter(Element)
	if Element then
		if getElementType (Element) == "player" then
			if not scooter [getPlayerName(Element)] then
				ChangeChallanges()
				local tms = math.random(1,#team)
				setElementPosition (Element,team[tms][1],team[tms][2],team[tms][3])
				scooter[getPlayerName(Element)] = createVehicle (539,team[tms][1],team[tms][2],team[tms][3],team[tms][4],team[tms][5],team[tms][6])
				warpPedIntoVehicle (Element,scooter[getPlayerName(Element)])
				setVehicleDamageProof (scooter[getPlayerName(Element)],true)
				showCursor(false)
				setVehicleColor (scooter[getPlayerName(Element)],team[tms][6],team[tms][8],team[tms][9])
			else
				outputChatBox ("Du hast bereits einen Scooter!",Element,255,0,0)
			end
		end
	end
end
addEvent ("reinda",true)
addEventHandler("reinda",getRootElement(),enterscooter)

-- function scootercost ()
-- 	if enterscooter (true) then
-- 		if vioGetElementData(player,"money") >= 50 then
-- 		vioSetElementData(player,"money",vioGetElementData(player,"money")-50)
-- 		end
-- 	end
-- end
-- addEventHandler (scootercost)--

function stopenter (player,seat,jacked)
	if (scooter [getPlayerName(jacked)]) then
		if source == scooter[getPlayerName(jacked)] then
			cancelEvent()
		end
	end
end
addEventHandler ("onVehicleStartEnter",getRootElement(),stopenter)

function DelScooter(player)
    if player then
        if getElementModel(source) == 539 then
            if (scooter [getPlayerName(player)]) then
                if source == scooter[getPlayerName(player)] then
                    destroyElement(scooter[getPlayerName(player)])
					setElementPosition(player,-1717.3046875,134.5986328125,3.5546875)
					setElementRotation(player,0,0,268.26550292969)
                    scooter[getPlayerName(player)] = nil
                end
            end
        end
    end
end
addEventHandler("onVehicleExit",getRootElement(),DelScooter)




















