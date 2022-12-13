local Klaus1 = nil
local Klaus2 = nil
local Klaus3 = nil
local Klaus4 = nil
local Klaus5 = nil
local Klaus6
local Klaus7
local Klaus8
local Klaus9
local Klaus10
local rnd
local fragentimer
local gewinnertimer
local PortOpen = false
local col = createColCuboid (4100.2260742188,990.123046875,85.300003051758,265,200,50)
local colboat = createColCuboid (4138.9018554688,1179,92.511825561523,50,9,6)
local players = {}
--local simonmarker = {
--{createMarker(4138.9018554688,1179,92.511825561523,'corona',2.0,255,0,0,150)}1,--
--{createMarker(4138.9018554688,1170,90,'corona',2.0,255,0,0,150)}2},--
--}--

local fragen = {
{"Simon says: Hock dich hin!",5},
{"Simon says: Töte ein NPC!",50},
{"Simon says: Verlasse die Map!",120},
{"Simon says: Tanz!",8},
{"Simon says: Spring auf das Schiff!",20},
{"Simon says: Renne durch die Marker",10},
}
local points = {}
Klaus6 = createObject (6959,4305.1000976563,1116.1999511719,139.39999389648,90,0,0)
Klaus7 = createObject (6959,4285.2998046875,1097.0999755859,139.39999389648,90,90,0)
Klaus8 = createObject (6959,4306,1076.5,139.39999389648,90,0,0)
Klaus9 = createObject (6959,4325.7998046875,1096.1999511719,139.39999389648,90,90,0)
Klaus10 = createObject (6959,4305.6000976563,1096.1999511719,136,0,0,0)
setElementAlpha(Klaus6,0)
setElementAlpha(Klaus7,0)
setElementAlpha(Klaus8,0)
setElementAlpha(Klaus9,0)
setElementAlpha(Klaus10,0)

function getAdminLevel(player)
	admin = call(getResourceFromName("vio"),"vioGetElementData",player,"adminlvl")
	if admin then
		return admin
	else
		return 0 
	end
end

function CreateBarrier()
	Klaus1 = createObject (6959,4175.5,1096.0999755859,110,0,0,0)
	Klaus2 = createObject (6959,4155,1094.8000488281,90.300003051758,90,90,0)
	Klaus3 = createObject (6959,4175.5,1114,90.300003051758,90,0,0)
	Klaus4 = createObject (6959,4195.7001953125,1095.6999511719,90.300003051758,90,90,0)
	Klaus5 = createObject (6959,4174.5,1076.6999511719,91,90,0,0)
	setElementAlpha(Klaus1,0)
	setElementAlpha(Klaus2,0)
	setElementAlpha(Klaus3,0)
	setElementAlpha(Klaus4,0)
	setElementAlpha(Klaus5,0)
end

function consoleSetPlayerPosition(element)
    if element then
        if getElementType(element) == "player" then
            if getPedOccupiedVehicle(element) then
            else
                setElementPosition(element, 4304.7036132812,1094.3825683594,136.96875)
            end
        end
    end
end
addCommandHandler("zuschauen", consoleSetPlayerPosition)

function consoleSetPlayerPosition(element)
	if element then
		if PortOpen == true then 
			if getElementType (element) == "player" then
				if getElementDimension(element) == 0 then
					if getElementInterior(element) == 0 then 
						if getPedOccupiedVehicle(element) then 
							outputChatBox("Du darfst nicht im Fahrzeug sitzen!",element)
						else
							setElementPosition(element, 4182.3510742188,1095.0302734375,91.300003051758)
						end
					end
				end
			end
		else
			outputChatBox("Der Port ist geschlossen",element)
		end
	end
end
addCommandHandler("gotoevent", consoleSetPlayerPosition)

function toggleeventport(player)
	if player then 
		if PortOpen == true then 
			PortOpen = false
			destroyElement(Klaus1)
			destroyElement(Klaus2)
			destroyElement(Klaus3)
			destroyElement(Klaus4)
			destroyElement(Klaus5)
			outputChatBox("Der Port ist: geschlossen",player)
		elseif PortOpen == false then 
			PortOpen = true
			CreateBarrier()
			outputChatBox("Der Port ist: offen",player)
		end
	end
end
addCommandHandler("toggleport",toggleeventport)

function startsimonsays(element)
	if element then 
			players = getElementsWithinColShape (col,"player")
			for _, player in ipairs(players) do
				players[player] = 0
			end
			rnd = math.random(1,#fragen)
			fragentimer = setTimer(gameover,fragen[rnd][2]*1000,1)
			gewinnertimer = setTimer(gewinner,1000,fragen[rnd][2])  
			optoplayers(fragen[rnd][1],114,241,247)
	end
end
addCommandHandler("startsimon",startsimonsays)

function optoplayers(output, r, g, b)
	for _, player in ipairs(players) do
		outputChatBox(output, player, r, g, b)
	end
end

function leaveevent(element)
	if element then 
		if getElementType(element) == "player" then
			outputChatBox("Du hast das Spielfeld verlassen",element,255,0,0)
		end
	end
end
addEventHandler("onColShapeLeave",col,leaveevent)

function questions(element)
	if element then
		if getElementType(element) == "player" then
			if rnd == 5 then
				optoplayers("Simon says: "..getPlayerName(element).." hat die Aufgabe bestanden!",0,125,0)
				players[element] = 1
			end
		end
	end
end
addEventHandler("onColShapeHit",colboat,questions)

function gameover()
	if isTimer(gewinnertimer) then 
		killTimer(gewinnertimer)
	end
	for _, player in ipairs(players) do
		if players[player] == 0 then
			outputChatBox("Simon says: Du warst leider zu langsam!",player,255,0,0)
			setElementPosition(player, 4304.7036132812,1094.3825683594,136.96875)
		end
	end
end

function gewinner()
	if isTimer(fragentimer) then
		if rnd == 1 then
			for _, player in ipairs(players) do
				if players[player] == 0 then
					if isPedDucked(player)	then
							optoplayers("Simon says: "..getPlayerName(player).." hat die Aufgabe bestanden!",0,125,0)
							players[player] = 1
							killTimer(fragentimer)
					end
				end
			end
		end
	end
end


function dance(element)
	if element then 
		if getElementType(element) == "player" then
			if isTimer(fragentimer) then
				if rnd == 4 then
					if vioGetElementData(element,"simonsaysdance") == 1 then
						optoplayers("Simon says: "..getPlayerName(element).." hat die Aufgabe bestanden!",0,125,0)
						players[element] = 1
						vioSetElementData(element,"simonsaysdance",0) 
					else
					end
				end
			end
		end
	end
end
addCommandHandler("startsimon",dance)

function canceltimer(element)
	if (getAdminLevel(element) >= 5) then
		if element == element then
			killTimer(gewinnertimer)
			killTimer(fragentimer)
			outputChatBox("Die Aufgabe wurde übersprungen!",element,255,0,0)
		end
	end
end
addCommandHandler("skip",canceltimer)