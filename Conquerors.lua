-- Last Update 2020
-- Variables and Tables 

local keys = {70,76,77,81}

local formedN = {'Rio de La Plata', 'Peru-Bolivian Confederation', 'Empire of Brazil', 'Patagonia', 'Gran-Colombia', 'Audiencia of Quito', 'Empire of Paraguay', 'Inca Empire', 'Oriental Kingdom', 'Bolivar Empire'}
local formedNeed = {{1,2,3,4,5,6,7,8,15,18,27,32},{7,8,15,18,27,28,29,30,31}, {9,10,11,12,13,14,15,16,32}, {2,3,5,17,18,19,20}, {21,22,23,24,25,33,34,35}, {21,24,25,31} ,{4,5,12,26,27}, {17,18,24,25,28,29,30,31}, {1,32}, {7,8,15,21,22,23,24,25,27,28,29,30,31,33,34,35}}

local game = {
	countries = {
		[1]  = {n = 'Argentina', s = 'AR'},	
		[2]  = {n = 'Bolivia', 	 s = 'BO'},
		[3]  = {n = 'Brazil', 	 s = 'BR'},
		[4]  = {n = 'Chile', 	 s = 'CL'},
		[5]  = {n = 'Colombia',	 s = 'CO'},
		[6]  = {n = 'Ecuador', 	 s = 'EC'},
		[7]  = {n = 'Paraguay',	 s = 'PY'},
		[8]  = {n = 'Peru', 	 s = 'PE'},
		[9]  = {n = 'Uruguay',	 s = 'UY'},	
		[10] = {n = 'Venezuela', s = 'VE'},

		removeCity = function(self, cityName)
			local removeValue
			for k,v in next, self.cities do
				if v[2] == cityName then
					removeValue = k
					break
				end
			end
			table.remove(self.cities, removeValue)
			if #self.cities == 0 then
				notifyPlayer(nil, ('%s collapsed!'):format(self.n), false)
			end
		end,

		addCity = function(self, cityName, cityMousepower)
			local args = {cityMousepower, cityName}
			table.insert(self.cities, args)
			if #self.cities == 35 then
				notifyPlayer(nil, ('Congratulations! %s won the game as %s!'):format(self.leader, self.n), false)
				won()
			end
		end,
	},

	cities = {
		[1] = {
			id = 10000,
			n = 'Buenos Aires',
			mousepower 	= 302.5,
			x = 622, y = 270, l = 46, h = 20
		},
		[2] = {
			id = 10001,
			n = 'Bariloche',
			mousepower 	= 10.1,
			x = 622, y = 270, l = 20, h = 50
		},
		[3] = {
			id = 10002,
			n = 'Comodoro Rivadavia',
			mousepower 	= 3.4,
			x = 622, y = 320, l = 12, h = 40
		},
		[4] = {
			id = 10003,
			n = 'Cordóba',
			mousepower = 44.5,
			x = 620, y = 210, l = 55, h = 55
		},
		[5] = {
			id = 10004,
			n = 'Posadas',
			mousepower 	= 9.1,
			x = 670, y = 238, l = 15, h = 15
		},
		[6] = {
			id = 10005,
			n = 'Ushuaia',
			mousepower 	= 1.4,
			x = 632, y = 375, l = 8, h = 8
		},
		[7] = {
			id = 20000,
			n = 'La Paz',
			mousepower 	= 52.5,
			x = 620, y = 148, l = 20, h = 55
		},
		[8] = {
			id = 20001,
			n = 'Santa Cruz',
			mousepower 	= 53.9,
			x = 640, y = 168, l = 40, h = 40
		},
		[9] = {
			id = 30000, 
			n = 'Brasília',
			mousepower 	= 74.3,
			x = 670, y = 110, l = 65, h = 105
		},
		[10] = {
			id = 30001,
			n = 'Boa Vista',
			mousepower	= 6,
			x = 640, y = 70, l = 20, h = 20
		},
		[11] = {
			id = 30002,
			n = 'Manaus',
			mousepower	= 27.8,
			x = 610, y = 90, l = 90, h = 50
		},
		[12] = {
			id = 30003,
			n = 'Porto Alegre',
			mousepower 	= 31,
			x = 690, y = 215, l = 16, h = 36
		},
		[13] = {
			id = 30004,
			n = 'Porto Velho',
			mousepower 	= 9.1,
			x = 640, y = 130, l = 30, h = 30
		},
		[14] = {
			id = 30005,
			n = 'Recife',
			mousepower 	= 38.8,
			x = 740, y = 125, l = 36, h = 66
		},
		[15] = {
			id = 30006,
			n = 'Rio Branco',
			mousepower 	= 10.2,
			x = 600, y = 130, l = 20, h = 20
		},
		[16] = {
			id = 30007,
			n = 'São Paulo',
			mousepower 	= 275.1,
			x = 710, y = 175, l = 40, h = 40
		},
		[17] = {
			id = 40000,
			n = 'Santiago',
			mousepower 	= 160.4,
			x = 610, y = 220, l = 6, h = 60
		},
		[18] = {
			id = 40001,
			n = 'Antofagasta',
			mousepower 	= 9.7,
			x = 608, y = 190, l = 6, h = 30
		},
		[19] = {
			id = 40002,
			n = 'Concepción',
			mousepower 	= 8.6,
			x = 610, y = 280, l = 6, h = 80
		},
		[20] = {
			id = 40003,
			n = 'Punta Arenas',
			mousepower = 3.1,
			x = 620, y = 365, l = 10, h = 10
		},
		[21] = {
			id = 50000,
			n = 'Bogotá',
			mousepower 	= 275.3,
			x = 570, y = 80, l = 34, h = 20
		},
		[22] = {
			id = 50001,
			n = 'Barranquilla',
			mousepower 	= 40.1,
			x = 577, y = 45, l = 14, h = 30
		},
		[23] = {
			id = 50002,
			n = 'Bucaramanga',
			mousepower 	= 14.5,
			x = 597, y = 62, l = 20, h = 20
		},
		[24] = {
			id = 60000,
			n = 'Quito',
			mousepower 	= 60.4,
			x = 555, y = 95, l = 20, h = 10
		},
		[25] = {
			id = 60001,
			n = 'Guayaquil',
			mousepower 	= 57.3,
			x = 555, y = 110, l = 10, h = 10
		},
		[26] = {
			id = 70000,
			n = 'Asunción',
			mousepower = 65.5,
			x = 670, y = 218, l = 14, h = 14
		},
		[27] = {
			id = 70001, 
			n = 'Pedro Juan Caballero', 
			mousepower = 25.2, 
			x = 653, y = 202, l = 16, h = 16},
		[28] = {
			id = 80000,
			n = 'Lima',
			mousepower = 232.5,
			x = 575, y = 135, l = 20, h = 30
		},
		[29] = {
			id = 80001,
			n = 'Cuzco',
			mousepower = 10.7,
			x = 587, y = 155, l = 25, h = 30
		},
		[30] = {
			id = 80002,
			n = 'Iquitos',
			mousepower = 11.4,
			x = 555, y = 125, l = 30, h = 20
		},
		[31] = {
			id = 80003,
			n = 'Trujillo',
			mousepower 	= 21,
			x = 573, y = 108, l = 30, h = 20
		},
		[32]	= {
			id = 90000,
			n = 'Montevideo',
			mousepower 	= 74.5,
			x = 672, y = 256, l = 18, h = 18
		},
		[33] = {
			id = 100000,
			n = 'Caracas',
			mousepower 	= 102,
			x = 614, y = 48, l = 36, h = 22
		},
		[34] = {
			id = 100001,
			n = 'Maracaibo',
			mousepower	= 57.3,
			x = 600, y = 45, l = 12, h = 12,
		},
		[35] = {
			id = 100002,
			n = 'Puerto Ayacucho',
			mousepower	= 1.3,
			x = 625, y = 75, l = 10, h = 10,
		},

		recruit = function(self, amount)
			local amount = amount and amount or 10000
			self.troops = self.troops + amount
		end,

		clearTroops = function(self)
			self.troops = 0
		end,

		transfer = function(self, countryID, cityID)
			local country = countries[countryID]
			self.country:removeCity(self.n)
			self.country = country
			country:addCity(self.n, self.mousepower)
		end,
	},
}

local playersList 	= {}

local players = {
	new = function(name)
		return {
			name = name,

			firstID 	= nil,
			countryID 	= nil,
			selectedID 	= nil,

			borders = false,
			playing = false,
			countryOpen = false,
			rankingOpen = false,
			showingMap = false,

			warns = {},
			relatory = {},
			callbacks = {},

			lastrecruit = os.time()-250,
			lastwarn = os.time()-500

		}
	end,

	choosed = function(self, countryID)
		self.playing = true
		self.countryID = countryID

		countries[countryID].leader = self.name

		displayCountry(self.name, countryID)
		see(self.name)
	end,

	joinedWar = function(self)
		table.insert(countries[self.countryID].enemies, countries[self.selectedID])
		table.insert(countries[self.selectedID].enemies, countries[self.countryID])
		see(self.name)

		local remove = {}

		for k,v in next, countries[self.selectedID].allies do
			table.insert(v.enemies, countries[self.countryID])
			for n,m in next, countries[self.countryID].allies do

				if m.leader ~= m.n .. ' Bot' then
					addPopup(m.leader, sizeX, sizeY, ('%s declared war at %s!'):format(countries[self.countryID].n, countries[self.selectedID].n), 'Damn!')
				end

				if m.n == v.n then
					table.insert(remove, n)

					local remove2 = {}

					for x,y in next, v.allies do
						if y.n == countries[self.countryID].n then
							table.insert(remove2, x)
						end
					end

					for a,b in next, remove2 do
						table.remove(v.allies, b)
					end
				end
			end
		end

		for k,v in next, remove do
			table.remove(countries[self.countryID].allies, v)
		end
	end,

	leftWar = function(self, id)

		local removeKey, removeKey2 = nil, nil
		local enemyTbl = countries[id]

		for k,v in next, countries[self.countryID].enemies do
			if v.n == enemyTbl.n then
				removeKey = k
				break
			end
		end

		for k,v in next, enemyTbl.enemies do
			if v.n == countries[self.countryID].n then
				removeKey2 = k
				break
			end
		end

		table.remove(enemyTbl.enemies, removeKey2)
		table.remove(countries[self.countryID].enemies, removeKey)
		see(self.name)
		
		self:joinedTruces(id)
	end,

	joinedTruces = function(self, id)

		local playerCountry = countries[self.countryID]
		local otherCountry = countries[id]

		addTimer(function(i)
			if i == 1 then
				table.insert(otherCountry.truces, playerCountry)
				table.insert(playerCountry.truces, otherCountry)
			elseif i == 180 then
				if playersList[playerCountry.leader] then
					addPopup(playerCountry.leader, sizeX, sizeY, ('Our truce with %s has finished'):format(otherCountry.n), 'Okay')
				end
				if playersList[otherCountry.leader] then
					addPopup(otherCountry.leader, sizeX, sizeY, ('Our truce with %s has finished'):format(playerCountry.n), 'Okay')
				end
				table.remove(otherCountry.truces, 1)
				table.remove(playerCountry.truces, 1)
			end
		end, 1000, 180)
	end,

	joinedAlliance = function(self, id)
		table.insert(countries[self.countryID].allies, countries[id])
		table.insert(countries[id].allies, countries[self.countryID])
		see(self.name)
	end,

	leftAlliance = function(self)
		local playerCountry = countries[self.countryID]
		local allyTbl = countries[self.selectedID]

		local remove, remove2

		for k,v in next, playerCountry.allies do
			if v.n == allyTbl.n then
				remove = k
				break
			end
		end
		for k,v in next, allyTbl.allies do
			if v.n == playerCountry.n then
				remove2 = k
				break
			end
		end

		table.remove(playerCountry.allies, remove)
		table.remove(allyTbl.allies, remove2)

		self:joinedTruces(self.selectedID)
	end,

	addBorders = function(self)
		self.borders = not self.borders
	end,

	forming = function(self)
		local id = self.countryID
		if #countries[id].enemies > 0 then
			return warnPlayer(self.name, 'Need be at peace!')
		end

		for k,v in next, formedNeed[id] do
			if cities[v].country.n ~= countries[id].n then
				return warnPlayer(self.name, 'Press M for info')
			end
			if k == #formedNeed[id] then
				countries[id].n = formedN[id]
			end
		end
		see(self.name)
	end,
}

-- Timer

do
	local List = {}
	function List.new ()
		return {first = 0, last = -1}
	end

	function List.pushleft (list, value)
		local first = list.first - 1
		list.first = first
		list[first] = value
	end

	function List.pushright (list, value)
		local last = list.last + 1
		list.last = last
		list[last] = value
	end

	function List.popleft (list)
		local first = list.first
		if first > list.last then
			return nil
		end
		local value = list[first]
		list[first] = nil        -- to allow garbage collection
		list.first = first + 1
		return value
	end

	function List.popright (list)
		local last = list.last
		if list.first > last then
			return nil
		end
		local value = list[last]
		list[last] = nil         -- to allow garbage collection
		list.last = last - 1
		return value
	end

	-- the lib
	local timerList = {}
	local timersPool = List.new()

	function addTimer(callback, ms, loops, label, ...)
		local id = List.popleft(timersPool)
		if id then
			local timer = timerList[id]
			timer.callback = callback
			timer.label = label
			timer.arguments = {...}
			timer.time = ms
			timer.currentTime = 0
			timer.currentLoop = 0
			timer.loops = loops or 1
			timer.isComplete = false
			timer.isPaused = false
			timer.isEnabled = true
		else
			id = #timerList+1
			timerList[id] = {
				callback = callback,
				label = label,
				arguments = {...},
				time = ms,
				currentTime = 0,
				currentLoop = 0,
				loops = loops or 1,
				isComplete = false,
				isPaused = false,
				isEnabled = true,
			}
		end
		return id
	end

	function getTimerId(label)
		local found
		for id = 1, #timerList do
			local timer = timerList[id]
			if timer.label == label then
				found = id
				break
			end
		end
		return found
	end

	function pauseTimer(id)
		if type(id) == 'string' then
			id = getTimerId(id)
		end

		if timerList[id] and timerList[id].isEnabled then
			timerList[id].isPaused = true
			return true
		end
		return false
	end

	function resumeTimer(id)
		if type(id) == 'string' then
			id = getTimerId(id)
		end

		if timerList[id] and timerList[id].isPaused then
			timerList[id].isPaused = false
			return true
		end
		return false
	end

	function removeTimer(id)
		if type(id) == 'string' then
			id = getTimerId(id)
		end

		if timerList[id] and timerList[id].isEnabled then
			timerList[id].isEnabled = false
			List.pushright(timersPool, id)
			return true
		end
		return false
	end

	function clearTimers()
		local timer
		repeat
			timer = List.popleft(timersPool)
			if timer then
				table.remove(timerList, timer)
			end
		until timer == nil
	end

	function timersLoop()
		for id = 1, #timerList do
			local timer = timerList[id]
			if timer.isEnabled and timer.isPaused == false then
				if not timer.isComplete then
					timer.currentTime = timer.currentTime + 500
					if timer.currentTime >= timer.time then
						timer.currentTime = 0
						timer.currentLoop = timer.currentLoop + 1
						if timer.loops > 0 then
							if timer.currentLoop >= timer.loops then
								timer.isComplete = true
								if eventTimerComplete ~= nil then
									eventTimerComplete(id, timer.label)
								end
								removeTimer(id)
							end
						end
						if timer.callback ~= nil then
							timer.callback(timer.currentLoop, table.unpack(timer.arguments))
						end
					end
				end
			end
		end
	end
end

-- Initializing game info

addInfo = function()
	local colors = {'0x00FFF9', '0xFF8F00', '0x02FF00', '0x6B4A2C', '0x9100FF', '0xEB00FF', '0x002EFF', '0xFF006C', '0xFFF000', '0xFF0000'}
	for k,v in next, game.countries do
		if type(v) == 'table' then
			v.truces 	= {}
			v.allies 	= {}
			v.cities 	= {}
			v.enemies	= {}

			v.ipower	= 0
			v.power 	= 50000
			v.leader 	= ('%s Bot'):format(v.n)
			v.color 	= colors[k]
			v.capital	= '?'

			setmetatable(v, {__index = game.countries})
		else
			break
		end
	end
	for k,v in next, game.cities do
		if type(v) == 'table' then
			countryID 	= math.floor(v.id/10000)
			v.country 	= game.countries[countryID]
			v.troops 	= 0

			setmetatable(v, {__index = game.cities})
			local args = {v.mousepower, v.n}
			table.insert(game.countries[countryID].cities, args)

			if v.id%10000 == 0 then
				game.countries[countryID].capital = v.n
				v.mousepower 	= v.mousepower + 50
				v.troops 		= 50000
			end
		else
			break
		end
	end
end; addInfo()

local gameSave

loadGame = function(save)
	function copy(tbl)
		local new = {}
		for k, v in next, tbl do
			if type(v) == "table" then
				new[k] = copy(v)
			else
	    		new[k] = v
			end
		end
		return new
	end

    if save then
        gameSave = copy(game)
    else 
        game = gameSave
    end

	countries 	= game.countries
	cities 		= game.cities

end; loadGame(true)

-- TextArea manipulation

local buttonId = 0

addCities = function(player)
	for i=1,#cities do
		for k,v in next, playersList do
			if type(v) == 'table' then
				local color = playersList[k].borders and 0x6A7495 or cities[i].country.color
				ui.addTextArea(cities[i].id, "<font size='80'>"..string.rep('\n', 20),  k, cities[i].x, cities[i].y, cities[i].l, cities[i].h, cities[i].country.color, color, 1, true, 
					function(player)
						displayCity(player, i)
					end)
			end
		end
	end
end

addCitiesWar = function(player)
	for i=1,#cities do
		ui.addTextArea(cities[i].id, "<font size='80'>"..string.rep('\n', 20),  player, cities[i].x, cities[i].y, cities[i].l, cities[i].h , cities[i].country.color, 0x6A7495, 1, true, 
			function(player)
				moveTroops(player, i)
			end)
	end
end

showMapForming = function(player)
	for i=1,#cities do
		local alpha = 0
		local color
		for k,v in next, formedNeed[playersList[player].countryID] do
			if i == v then
				if cities[i].country.n == countries[playersList[player].countryID].n then
					color = 0x0FF000
					alpha = 1
					break
				elseif cities[i].country.n ~= countries[playersList[player].countryID].n then
					color = 0xFF0000
					alpha = 1
					break
				end
			else
				color = 0x6A7495
			end
		end
		ui.addTextArea(cities[i].id, "",  player, cities[i].x, cities[i].y, cities[i].l, cities[i].h, color, color, alpha, true, 
			function(player)
				addCities(player)
			end)
	end
end

loadMap = function(player)
	ui.addTextArea(110000, "", player, 660,70,32,13, 0xFFFFFF, 0xFFFFFF, 1, true)
	ui.addTextArea(110001, "", player, 655,60,15,10, 0xFFFFFF, 0xFFFFFF, 1, true)

	addCities(player)
end

local addTextArea = ui.addTextArea

ui.addTextArea = function(id, text, player, x, y, width, height, color1, color2, alpha, followPlayer, callback, args)
    if callback and playersList[player] then 
        playersList[player].callbacks[#playersList[player].callbacks+1] = {event = callback, callbacksx = args}
        text = '<a href="event:callback_'..#playersList[player].callbacks ..'">'..text
    end
    return addTextArea(id, text, player, x, y, width, height, color1, color2, alpha, followPlayer, callback)
end

-- #conquerors Important Functions

cityIsSomething = function(player, id, name)
	local countryID = playersList[player].countryID
	local enemyName = cities[id].country.n
	for k,v in next, countries do
		if v.n == enemyName then
			return isSomething(name, countryID, k)
		end
	end
end

cityIsTrulyEnemy = function(player, id)
	local cityCountry = countries[math.floor(cities[id].id/10000)].n
	for k,v in next, cities[id].country.enemies do
		if v.n == cityCountry then
			return false
		elseif cityCountry == cities[id].country.n then
			return true
		end
	end
	return true
end

getLists =  function(country)
	local total, returning = {}, {}
	for _,name in next, {'allies', 'enemies', 'truces'} do
		total[name] = {}
		for k,v in next, country[name] do
			table.insert(total[name], v.s)
		end
		local concat = table.concat(total[name], ", ")
		table.insert(returning, concat)
	end
	return table.unpack(returning)
end

isSomething = function(name, playerID, otherID)
	for k,v in next, countries[otherID][name] do
		if countries[playerID].n == v.n then
			return true
		end
	end
	return false
end

won = function()
	addTimer(function(i)
		if i == 10 then
			for k,v in next, playersList do
				tfm.exec.killPlayer(v.name)
				closeTextArea(v.name)
				v.firstID 	= nil
				v.countryID 	= nil
				v.selectedID 	= nil

				v.playing = false
				v.countryOpen = false
				v.rankingOpen = false
				v.showingMap = false

				v.warns = {}
				v.relatory = {}
				v.callbacks = {}
			end
			loadGame(false)
			table.foreach(tfm.get.room.playerList, eventNewPlayer)
		end
	end, 1000, 10)
end

-- #conquerors TextArea manipulation

see = function(player)
	return displayCountriesList(player, '<N>', false,
		function(player)
			local id = playersList[player].selectedID
			displayCountry(player, id)
		end)
end

addPopup = function(player, sizeX, sizeY, text, textButton)
	closeTextArea(player)
	local sizeX = sizeX and sizeX or 200
	local sizeY = sizeY and sizeY or 120
	local initialX = 400 - sizeX/2
	local initialY = 200 - sizeY/2
	local decoSize = sizeX > sizeY and sizeX/10 or sizeY/10
	ui.addTextArea(1000, "", player, initialX, initialY, sizeX, sizeY, 0x324650, 0x324650, 1, true)
	ui.addTextArea(1001, "", player, initialX, initialY, decoSize, decoSize, 0x009D9D, 0x009D9D, 1, true)
	ui.addTextArea(1002, "", player, initialX + sizeX - decoSize, initialY, decoSize, decoSize, 0x009D9D, 0x009D9D, 1, true)
	ui.addTextArea(1003, "", player, initialX, initialY + sizeY - decoSize, decoSize, decoSize, 0x009D9D, 0x009D9D, 1, true)
	ui.addTextArea(1004, "", player, initialX + sizeX - decoSize, initialY + sizeY - decoSize, decoSize, decoSize, 0x009D9D, 0x009D9D, 1, true)
	if text then
		ui.addTextArea(1005, ("<p align='center'><b><font color='#324650'><font size='20'>Warning!</font><font size='11'>\n\n%s</font>"):format(text), player, initialX + 5, initialY + 5, sizeX - 10, sizeY - 10, 0x9292AA, 0x9292AA, 1, true)
		if textButton then
			addButton(player, textButton, x, y, 120)
		end
	end
end

addButton = function(player, text, x, y, sizeX, sizeY, ...)
	buttonId = buttonId + 2
	local event = (...) and (...) or (function(player) closeTextArea(player) end)
	local sizeX = sizeX and sizeX or 60
	local sizeY = sizeY and sizeY or 18
	local x 	= x and x or 400 - sizeX/2
	local y 	= y and y or 240 - sizeY/2
	ui.addTextArea(1017 + buttonId, "", player, x+1, y+1, sizeX, sizeY, 0x0e1619, 0x0e1619, 1, true)
	ui.addTextArea(1018 + buttonId, ("<B><p align='center'>%s"):format(text), player, x, y, sizeX, sizeY, 0x324650, 0x324650, 1, true, event)
end

addRanking = function(player)
	addPopup(player, 400, 250)
	ui.addTextArea(1005, "<p align='center'><b><N><font size='20'><u>Ranking", player, 205, 80, 390, 240, 0x324650, 0x324650, 1, true)
	for i=1,10 do
		ui.addTextArea(1005+i, "", player, 260, 118 + i*17, countries[i].ipower/9, 2, countries[i].color, 0x324650, 1, true)
	end
	ui.addTextArea(1016, "<b><N><font size='14'>AR\nBO\nBR\nCL\nCO\nEC\nPY\nPE\nUY\nVE", player, 220, 125, 390, 240, 0x324650, 0x324650, 0, true)
	addButton(player, 'Interesting', x, 320, 120)
end

addRelatory = function(player)
	addPopup(player, 400, 250)
	--{cities[finishID].n, cities[startID].country.n, troopsLeft, cities[startID].country.leader, cities[finishID].country.leader, bonus, entrenchedTroops, startTroops, startDefend}
	local a,b,c,d,e,f,g,h,i = table.unpack(playersList[player].relatory[1])
	local bonus = f > 1 and ('Bonus: <VP>+%d%s'):format(f*100-100,'%') or ('Attrition: <R>-%d%s'):format(100-f*100,'%')
	local winner = c > 1 and d or e
	ui.addTextArea(1005, ("<p align='center'><b><N><font size='20'><u>Battle of %s</u>\n\n\n\n\n\n\n<font size='15'>%s won the battle!\n<BV><font size='15'>Troops left: <J>%d"):format(a,winner,c), player, 205, 80, 390, 240, 0x324650, 0x324650, 1, true)
	ui.addTextArea(1006, ("<b><N><p align='center'><u>%s forces</u>\n\n<BV>Troops: <J>%s\n<BV>%s\n<BV>Total: <J>%s"):format(d,h,bonus,math.floor(h*f)), player, 205, 130, 185, 165, 0x9292AA, 0x9292AA, 0, true)
	ui.addTextArea(1007, ("<b><N><p align='center'><u>%s forces</u>\n\n<BV>Troops: <J>%s\n<BV>Civilian Troops: <J>%s\n<BV>Total: <J>%s"):format(e,i,g,i+g), player, 410, 130, 185, 165, 0x9292AA, 0x9292AA, 0, true)

	ui.removeTextArea(2000000, player)
	ui.removeTextArea(2000001, player)

	addButton(player, 'Interesting', x, 320, 120)
end

addSettings = function(player)
	addPopup(player, 300, 200)
	ui.addTextArea(1005, "<p align='center'><b><font color='#324650'><font size='20'>Settings</font>", player, 255, 105, 290, 190, 0x9292AA, 0x9292AA, 1, true)
	ui.addTextArea(1006, "<p align='center'><b><BV>[•] <font color='#324650'>Add/remove borders of the map", player, 255, 145, 290, 20, 0, 0, 0, true, 
		function(player)
			playersList[player]:addBorders()
			addCities(player)
		end)
	addButton(player, 'Ready', x, 260, 120)
end

closeTextArea = function(player)
	buttonId = 0
	for i=0,25 do
		ui.removeTextArea(1000+i, player)
	end
end

warnPlayer = function(player, text)
	if playersList[player].lastwarn < os.time()-500 then
		local warns = playersList[player].warns
		table.insert(warns, #warns)
		addTimer(function(i)
			if i == 1 then
				ui.addTextArea(1000000+#warns, ("<p align='right'><b><font color='#000000'>%s"):format(text), player, 501, 371 - #warns * 20, 300, 20, 0, 0x324650, 0, true)
				ui.addTextArea(1000000-#warns, ("<p align='right'><b><R>%s"):format(text), player, 500, 370 - #warns * 20, 300, 20, 0, 0x324650, 0, true)
			elseif i == 3 then
				ui.removeTextArea(1000000+#warns, player)
				ui.removeTextArea(1000000-#warns, player)
				table.remove(warns, 1)
			end
		end, 1000, 3, 'warns')
		playersList[player].lastwarn = os.time()
	end
end

notifyPlayer = function(player, text, relatory)
	local relatory = relatory and function(player) addRelatory(player) end or function (player) closeTextArea(player) end
	addTimer(function(i)
		if i == 1 then
			ui.addTextArea(2000000, ("<p align='center'><b><font size='24' color='#000000'>%s"):format(text), player, 1, 341, 800, 60, 0, 0x324650, 0, true)
			ui.addTextArea(2000001, ("<p align='center'><b><font size='24'><J>%s"):format(text), player, 0, 340, 800, 60, 0, 0x324650, 0, true, relatory)
		elseif i == 10 then
			ui.removeTextArea(2000000, player)
			ui.removeTextArea(2000001, player)
		end
	end, 1000, 10, 'notifys')
end

-- #conquerors minor TextArea Functions

displayCountriesList = function(player, color, cancel, ...)
	for k,v in next, countries do
		if type(k) == 'number' then
			ui.addTextArea(k+10, ("<b><font color='#324650'>%s"):format(v.n), player, 41, 111 + (k-1)*20, 140, 20, 0x324650, 0x324650, 0, true)
			ui.addTextArea(k, ("<b>%s%s"):format(color, v.n), player, 40, 110 + (k-1)*20, 140, 20, 0x324650, 0x324650, 0, true, (...))
		else
			break
		end
	end

	if cancel then
		ui.addTextArea(21, ("<b><font color='#324650'>Cancel"), player, 41, 311, 140, 20, 0x324650, 0x324650, 0, true)
		ui.addTextArea(22, ("<b>Cancel"), player, 40, 310, 140, 20, 0x324650, 0x324650, 0, true, 
			function(player)
				see(player)
				ui.removeTextArea(21, player)
				ui.removeTextArea(22, player)
			end)
	else
		ui.removeTextArea(21, player)
		ui.removeTextArea(22, player)
	end
end

displayCity = function(player, id)
	local playerData = playersList[player]
	local city = cities[id]
	if playerData.playing and city.country.n == countries[playerData.countryID].n then
		addPopup(player, 200, 120)
		ui.addTextArea(1007, ("<p align='center'><b><font color='#324650'><font size='15'><u>%s</u><br><font size='13'>%s\n<font size='11'>\nTroops: %s\n+ %s</font>"):format(city.n, city.country.n, city.troops, city.mousepower), player, 305, 145, 190, 110, 0x9292AA, 0x9292AA, 1, true)

		ui.addTextArea(1008, "<b><font color='#324650'><font size='16'>X", player, 470, 145, 40, 40, 0x606090, 0x9292AA, 0, true,
			function(player)
				closeTextArea(player)
			end)

		addButton(player, "<font size='10'>Move/Attack", 310, y, 80, sizeY, 
			function(player)
				ui.updateTextArea(1007, ("<p align='center'><b><font color='#324650'><font size='20'>Warning!</font><font size='11'>\n\nChoose one city to attack/deploy the troops of %s</font>"):format(city.n), player)
				addButton(player, 'No', 320)
				addButton(player, 'Ok', 420, nil, nil, nil,
					function(player)
						playerData.firstID = id
						closeTextArea(player)
						addCitiesWar(player, id)
					end)
			end)
		addButton(player, 'Recruit', 410, y, 80, sizeY,
			function(player)
				if playerData.lastrecruit < os.time()-250 then
					if countries[playerData.countryID].power >= 10000 then
						cities[id]:recruit()
						displayCity(player, id)
						playerData.lastrecruit = os.time()
						countries[playerData.countryID].power = countries[playerData.countryID].power - 10000
					else
						return warnPlayer(player, 'Need at least 10000 mousepower')
					end
				end
			end)
	else
		addPopup(player, 200, 120)
		ui.addTextArea(1007, ("<p align='center'><b><font color='#324650'><font size='15'><u>%s</u><br><font size='13'>%s\n<font size='11'>\nTroops: %s\n+ %s</font>"):format(city.n, city.country.n, city.troops, city.mousepower), player, 305, 145, 190, 110, 0x9292AA, 0x9292AA, 1, true)
		addButton(player, 'Close')
	end
	buttonId = 0
end

displayCountry = function(player, id)
	addPopup(player, 400, 250)
	local playerData = playersList[player]
	local country = countries[id]

	ui.addTextArea(1005, ("<p align='center'><b><font color='#324650'><font size='20'>%s | %s\n<font size='14'>Capital: %s\n<font size='12'>Leader: %s"):format(country.s, country.n, country.capital, country.leader), player, 205, 80, 390, 240, 0x9292AA, 0x9292AA, 1, true)
	ui.addTextArea(1006, "<b><p align='center'><n><font size='11'><font color='#324650'>Declare War", player, 495, 160, 90, 20, 0xFF0000, 0x9292AA, 1, true, 
		function(player)
			displayCountriesList(player, '<R>', true,
				function(player)

					local isAlly = isSomething('allies', playerData.countryID, playerData.selectedID)
					local isEnemy = isSomething('enemies', playerData.countryID, playerData.selectedID)
					local isTruce = isSomething('truces', playerData.countryID, playerData.selectedID)

					if isEnemy or isTruce or isAlly or playerData.selectedID == playerData.countryID then
						see(player)
						return warnPlayer(player, "Can't declare war!")
					end
					playerData:joinedWar()
					addPopup(player, sizeX, sizeY, ('We declared war at %s'):format(countries[playerData.selectedID].n), 'Looks Good')
					if playersList[countries[playerData.selectedID].leader] then
						addPopup(countries[playerData.selectedID].leader, sizeX, sizeY, ('%s declared war at us'):format(countries[playerData.countryID].n), 'Looks Bad')
					end
				end)
		end)
	ui.addTextArea(1007, "<b><p align='center'><n><font size='11'><font color='#324650'>Conciliate", player, 495, 190, 90, 20, 0xFEB1FC, 0x9292AA, 1, true,
		function(player)
			displayCountriesList(player, '<CH2>', true,
				function(player)

					if not isSomething('enemies', playerData.countryID, playerData.selectedID) or playerData.selectedID == playerData.countryID then
						see(player)
						return warnPlayer(player, "Can't Conciliate!")
					end
					addPopup(player, sizeX, sizeY, ('We sent a conciliate request to %s'):format(countries[playerData.selectedID].n), 'Looks Good')

					see(player)

					local playerTwo = countries[playerData.selectedID].leader ~= countries[playerData.selectedID].n .. ' Bot'
					local playerTwoName = countries[playerData.selectedID].leader

					if playerTwo and #countries[playerData.selectedID].cities ~= 0 then
						local playerTwoName = countries[playerData.selectedID].leader
						addPopup(playerTwoName, sizeX, sizeY, ('%s sent us a conciliate request, what we should do'):format(countries[playerData.countryID].n))
						addButton(playerTwoName, 'Refuse', 320, nil, nil, nil,
							function(player)
								closeTextArea(player)
								addPopup(playerData.name, sizeX, sizeY, ('%s refused our conciliate request!'):format(playerTwoName), 'Damn!')
							end)

						addButton(playerTwoName, 'Accept', 420, nil, nil, nil,
							function(player)
								closeTextArea(player)
								playerData:leftWar(playersList[playerTwoName].countryID)
								addPopup(playerData.name, sizeX, sizeY, ('%s accepted our conciliate request!'):format(playerTwoName), 'Yay!')
							end)
					else
						closeTextArea(player)
						playerData:leftWar(playerData.selectedID)
						addPopup(player, sizeX, sizeY, ('%s accepted our conciliate request!'):format(countries[playerData.selectedID].n), 'Yay!')
						if playerTwo then
							addPopup(playerData.name, sizeX, sizeY, ('We accepted the request of peace of %s!'):format(countries[playerData.selectedID].n), 'Yay!')
						end
					end
				end)
		end)
	ui.addTextArea(1008, "<b><p align='center'><n><font size='11'><font color='#324650'>Ally with", player, 495, 220, 90, 20, 0x2ECF73, 0x9292AA, 1, true,
		function(player)
			displayCountriesList(player, '<VP>', true,
				function(player)
					local isEnemy = isSomething('enemies', playerData.countryID, playerData.selectedID)
					local isAlly = isSomething('allies', playerData.countryID, playerData.selectedID)

					if isEnemy or isAlly or playerData.selectedID == playerData.countryID then
						see(player)
						return warnPlayer(player, "Can't send alliance!")
					end

					addPopup(player, sizeX, sizeY, ('We sent a alliance request to %s'):format(countries[playerData.selectedID].n), 'Looks Good')
					see(player)

					local playerTwo = countries[playerData.selectedID].leader ~= countries[playerData.selectedID].n .. ' Bot'
					local playerTwoName = countries[playerData.selectedID].leader

					if playerTwo then
						addPopup(playerTwoName, sizeX, sizeY, ('%s sent us a alliance request, should we accept?'):format(countries[playerData.countryID].n))
						addButton(playerTwoName, 'Refuse', 320, nil, nil, nil,
							function(player)
								closeTextArea(player)
								addPopup(playerData.name, sizeX, sizeY, ('%s refused our mighty alliance!'):format(playerTwoName), 'Damn!')
							end)

						addButton(playerTwoName, 'Accept', 420, nil, nil, nil,
							function(player)
								closeTextArea(player)
								playerData:joinedAlliance(playersList[playerTwoName].countryID)
								addPopup(playerData.name, sizeX, sizeY, ('%s accepted our alliance!'):format(playerTwoName), 'Yay!')
							end)
					else
						closeTextArea(player)
						addPopup(playerData.name, sizeX, sizeY, ('%s refused our mighty alliance!'):format(playerTwoName), 'Damn!')
					end
				end)
		end)
	ui.addTextArea(1009, "<b><p align='center'><n><font size='11'><font color='#324650'>Unally with", player, 495, 250, 90, 20, 0xA4CF9E, 0x9292AA, 1, true,
		function(player)
			displayCountriesList(player, '<T>', true,
				function(player)

					local isAlly = isSomething('allies', playerData.countryID, playerData.selectedID)

					see(player)
					if not isAlly then
						return warnPlayer(player, "Can't unally!")
					end

					playerData:leftAlliance()
					addPopup(player, sizeX, sizeY, ('We broke ties with %s'):format(countries[playerData.selectedID].n), 'Looks Good')
					if playersList[countries[playerData.selectedID].leader] then
						addPopup(countries[playerData.selectedID].leader, sizeX, sizeY, ('%s broke ties with us!'):format(countries[playerData.countryID].n), 'Looks Bad')
					end

				end)
		end)
	if playerData.countryID == id then
		ui.addTextArea(1010, ("<b><p align='center'><n><font size='7'><font color='#324650'>Form %s"):format(formedN[id]), player, 495, 290, 90, 20, 0x2F7FCC, 0x9292AA, 1, true,
			function(player)
				playersList[player]:forming()
			end)
	end
	ui.addTextArea(1011, "<b><font color='#324650'><font size='20'>X", player, 570, 80, 40, 40, 0x606090, 0x9292AA, 0, true,
		function(player)
			closeTextArea(player)
		end)

	allies, enemies, truces = getLists(country)

	ui.addTextArea(1012, ("<b><font color='#324650'>Allies: %s"):format(allies), player, 220, 160, 250, 20, 0x9292AA, 0x324650, 1, true)
	ui.addTextArea(1013, ("<b><font color='#324650'>Enemies: %s"):format(enemies), player, 220, 190, 250, 20, 0x9292AA, 0x324650, 1, true)
	ui.addTextArea(1014, ("<b><font color='#324650'>Truces: %s"):format(truces), player, 220, 220, 250, 20, 0x9292AA, 0x324650, 1, true)
end

-- #conquerors gameFunctions

moveTroops = function(player, id)
	local playerData = playersList[player]
	local startID = playerData.firstID
	local finishID = id

	local troops = cities[startID].troops
	local defend = cities[finishID].troops

	if troops < 1 then
		addCities(player)		
		return warnPlayer(player, "Can't move/attack without troops")
	end

	local startTroops = troops
	local startDefend = defend

	if cityIsSomething(player, id, 'enemies') then
		local entrenchedTroops = math.floor(math.random(25, 200) * cities[finishID].mousepower)
		local bonus = math.random(60,120)/100

		troops = math.floor(troops * bonus)
		defend = defend + entrenchedTroops

		local troopsLeft = troops - defend

		cities[startID]:clearTroops()
		cities[finishID]:clearTroops()

		playerData.relatory = {}

		local args = {cities[finishID].n, cities[startID].country.n, troopsLeft, cities[startID].country.leader, cities[finishID].country.leader, bonus, entrenchedTroops, startTroops, startDefend}
		table.insert(playerData.relatory, args)

		local playerAttacked = playersList[cities[finishID].country.leader]
		if playerAttacked then
			table.insert(playerAttacked.relatory, args)
		end

		local winner = false

		if troopsLeft > 0 then
			winner = true
			cities[finishID]:recruit(troopsLeft)

			if cityIsTrulyEnemy(player, id) then
				cities[finishID]:transfer(playerData.countryID)
			else
				cities[finishID]:transfer(math.floor(cities[finishID].id/10000))
			end
			
			for k,v in next, playersList do
				addCities(k)
			end
		else
			local troopsLeftDefend = defend - troops - entrenchedTroops > 0 and defend - troops - entrenchedTroops or 0
			cities[finishID]:recruit(troopsLeftDefend)
			addCities(player)		
		end

		if winner then
			notifyPlayer(player, ('%s won the battle of %s!'):format(cities[startID].country.n, cities[finishID].n), true)
			if playerAttacked then
				notifyPlayer(playerAttacked.name, ('%s won the battle of %s!'):format(cities[startID].country.n, cities[finishID].n), true)
			end
		else
			notifyPlayer(player, ('%s won the battle of %s!'):format(cities[finishID].country.n, cities[finishID].n), true)
			if playerAttacked then
				notifyPlayer(playerAttacked.name, ('%s won the battle of %s!'):format(cities[finishID].country.n, cities[finishID].n), true)
			end
		end
	elseif cityIsSomething(player, id, 'allies') or cities[id].country.n == countries[playerData.countryID].n then
		cities[startID]:clearTroops()
		cities[finishID]:recruit(troops)
		addCities(player)
	else
		addCities(player)
	end
	displayCity(player, finishID)
end

-- TFM Functions

eventKeyboard = function(player, key)
	if not playersList[player].playing then
		return
	end

	if key == 81 then	-- Q
		if playersList[player].countryOpen then
			closeTextArea(player, 19)
		else
			displayCountry(player, playersList[player].countryID)
		end
		playersList[player].countryOpen = not playersList[player].countryOpen
		return
	elseif key == 70 then	-- F
		tfm.exec.playEmote(player, 10, countries[playersList[player].countryID].s)
		return
	elseif key == 76 then
		if playersList[player].rankingOpen then
			closeTextArea(player, 19)
		else
			addRanking(player)
		end
		playersList[player].rankingOpen = not playersList[player].rankingOpen
		return
	elseif key == 77 then
		if playersList[player].showingMap then
			addCities(player)
		else
			showMapForming(player)
		end
		playersList[player].showingMap = not playersList[player].showingMap
		return
	end
end

eventLoop = function()
	timersLoop()
end

eventNewPlayer = function(player)
	tfm.exec.respawnPlayer(player)
	tfm.exec.setNameColor(player, 0xC2C2DA)
	if not playersList[player] then
		local playerTable = players.new(player)

		setmetatable(playerTable, {__index = players})

		playersList[player] = playerTable
	end
	displayCountriesList(player, '<N>', false,
		function(player)
			if not playersList[player].playing then
				local id = playersList[player].selectedID
				if countries[id].leader == countries[id].n .. ' Bot' then
					for k,v in next, keys do
						system.bindKeyboard(player, v, true, true)
					end

					tfm.exec.setNameColor(player, countries[id].color)
					tfm.exec.playEmote(player, 10, countries[id].s)

					playersList[player]:choosed(id)
					ui.addTextArea(-75, "<font size='11' color='#8C96B7' face='Lucida Console'><b>2<font size='16'>1<font size='8'>3", player, 30, 377.5, 300, 40, -1, -1, 0, true,
						function(player)
							addRanking(player)
						end)
					ui.addTextArea(-25, "", player, 250, 377.5, 300, 40, -1, -1, 0, true)
					ui.addTextArea(-50, "<font size='16' color='#8C96B7' ><b>|||</b>", player, 760, 374.5, 40, 40, -1, -1, 0 , true,
						function(player)
							addSettings(player)
						end)
				end
			end
		end)
	loadMap(player)

	for i=-10,-1,1 do
		ui.addTextArea(i, string.rep("<font size='20'>\n",2), player, 16, 114 + ((-i)-1)*20, 22, 10, 0x324650, 0xFFFFFF, 0, true,
			function(player)
				tfm.exec.playEmote(player, 10, countries[-i].s)
			end)
	end
end; table.foreach(tfm.get.room.playerList, eventNewPlayer)

eventPlayerDied = function(player)
	tfm.exec.respawnPlayer(player)
	if playersList[player] and playersList[player].playing then
		tfm.exec.setNameColor(player, countries[playersList[player].countryID].color)
	else
		tfm.exec.setNameColor(player, 0xC2C2DA)
	end
end

eventPlayerLeft = function(player)
	if playersList[player].playing then
		playersList[player].playing = false
		for i=1,#countries do
			if player == countries[i].leader then
				countries[i].leader = countries[i].n .. ' Bot'
				break
			end
		end
	end
end

eventTextAreaCallback = function(id, player, callback)
    local playerData = playersList[player]

    if not (id > 1000 and id < 2000) then
    	playerData.selectedID = id
    end

    local args = {}
    for i in callback:gmatch('[^_]+') do
        args[#args+1] = i
    end
    
    local event = table.remove(args, 1)
    if event == 'callback' then
		return playerData.callbacks[tonumber(args[1])].event(player, playerData.callbacks[tonumber(args[1])].callbacksx)
	end
end

local mousepower = addTimer(function(i)
	for i=1,#countries do
		local mousepower = 0
		for k,v in next, countries[i].cities do
			mousepower = mousepower + math.ceil(v[1])
		end
		countries[i].ipower = mousepower
		countries[i].power = countries[i].power + mousepower
	end
	for k,v in next, playersList do
		if v.playing then
			ui.updateTextArea(-25, ("<p align='center'><font color='#8C96B7' face='Lucida Console' size='16'>Mousepower: <b>%d"):format(countries[playersList[k].countryID].power), playersList[k].name)
		end
	end
end, 500, 0)

tfm.exec.disableAutoShaman()
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoNewGame()
tfm.exec.newGame('<C><P /><Z><S><S L="800" o="596384" H="80" X="400" Y="410" T="12" P="0,0,.3,.2,,0,0,0" /><S P="0,0,.3,.2,,0,0,0" Y="110" L="10" H="10" c="4" i=",,1715aac7ab3.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="130" L="10" H="10" c="4" i=",,1715a904a5b.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="150" L="10" H="10" c="4" i=",,1715aac9223.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="170" L="10" H="10" c="4" i=",,1715a9090aa.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="190" L="10" H="10" c="4" i=",,1715a9032e3.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="210" L="10" H="10" c="4" i=",,1715a90a81d.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="230" L="10" H="10" c="4" i=",,1715a907938.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="250" L="10" H="10" c="4" i=",,1715a90d6fd.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="270" L="10" H="10" c="4" i=",,1715a9061c5.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="270" L="10" H="10" c="4" i=",,1715a9061c5.png" T="0" X="20" /><S P="0,0,.3,.2,,0,0,0" Y="290" L="10" H="10" c="4" i=",,1715a90bf8c.png" T="0" X="20" /></S><D /><O /></Z></C>')
ui.setMapName('<J>#conquerors</J>')
