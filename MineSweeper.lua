-- LAST UPDATE: 21/06/2020

local player 		= "Lucasrslv#0000" -- Change to your name

local minesweeper 	= { }
local isPressing 	= false
local bombs 		= 0
local bombscount 	= 0

local text = {
	[0] = ' ', 
	[1] = "<font color='#2F7FCC'>1", 
	[2] = "<font color='#2ECF73'>2", 
	[3] = "<font color='#CB546B'>3", 
	[4] = "<font color='#C53DFF'>4", 
	[5] = "<font color='#FFD800'>5", 
	[6] = "<font color='#FF00DC'>6",
	[7] = "<font color='#009D9D'>7",
	[8] = "<font color='#FF8547'>8",
	[false] = "<font color='#324650'>✱"
}

system.bindKeyboard(player, 17, true, true)
system.bindKeyboard(player, 17, false, true)

do 	-- Game functions
	minesweeper.add = function(x, y, m)
		minesweeper.info 	= {x = x, y = y, m = m}
		minesweeper.bombs 	= {}
		bombscount = 0

		local i = 0

		for y = 0, y-1 do
			for x = 0, x-1 do
				
				-- Add the tiles
				i = i + 1

				minesweeper[i] = {
					id 		= i, 
					bomb 	= false, 
					showing = false, 
					flagged = false, 
					value 	= 0, 
					x = x, y = y
				}

				setmetatable(minesweeper[i], {__index = minesweeper})
			end
		end

		while m > 0 do
			-- Insert the mines
			local mine = math.random(1, #minesweeper)
			if not minesweeper[mine].bomb then
				minesweeper[mine].bomb 	= true
				minesweeper[mine].value = false
				minesweeper[mine]:aroundIncrease(mine)

				minesweeper.bombs[mine] = mine
				bombscount = bombscount + 1
				m = m - 1
			end
		end
	end

	minesweeper.aroundIncrease = function(self)
		canIncrease = function(id)
			local fixedY = minesweeper[id] and minesweeper[id].y or true
			for id = id-1, id+1 do
				if not(id <= 0) and not(id > #minesweeper) and not (minesweeper[id].bomb) and minesweeper[id].y == fixedY then
					minesweeper[id]:increase()
				end
			end
		end
		canIncrease(self.id)
		canIncrease(self.id - minesweeper.info.x)
		canIncrease(self.id + minesweeper.info.x)
	end

	minesweeper.won = function()
		local i = 0
		if bombs == 0 then
			for idx, tile in next, minesweeper do
				if type(tile) == 'table' then
					if tile.showing == true then
						i = i + 1
					elseif tile.value ~= false then
						break
					end
				end
			end
		end
		if i == #minesweeper - bombscount then
			ui.addTextArea(-3, "<p align='center'><b><font size='30' color='#CED8FB'>\n\n\n\nVocê VENCEU!", nil, 0, 0, 800, 400, 0x2ECF73,0x2ECF73,0.5)
			ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
			ui.addPopup(-2, 2, '', nil, 25, 310, 110)
		end
	end

	minesweeper.increase = function(self)
		self.value = self.value + 1
	end

	minesweeper.show = function(self)
		ui.addTextArea(self.id, ("<b><p align='center'>%s"):format(text[self.value]), nil, 160+((self.id-1)%minesweeper.info.x)*26,30+math.floor((self.id-1)/minesweeper.info.x)*26,18,18, 0xCED8FB, 0x485273)
		self.showing = true

		canShow = function(id)
			local fixedY = minesweeper[id] and minesweeper[id].y or true
			for id = id-1, id+1 do
				if minesweeper[id] and not minesweeper[id].showing and minesweeper[id].value and minesweeper[id].y == fixedY then
					minesweeper[id]:show()
				end
			end
		end

		if self.flagged then
			self.flagged = false
			bombs = bombs + 1
			ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
			ui.addPopup(-2, 2, '', nil, 25, 310, 110)
		end

		if self.value and self.value == 0 then
			canShow(self.id)
			canShow(self.id - minesweeper.info.x)
			canShow(self.id + minesweeper.info.x)
		end
		minesweeper.won()
	end

	minesweeper.flag = function(self)
		self.flagged = true
		bombs = bombs - 1

		ui.updateTextArea(self.id, ("<p align='center'><a href='event:flag'><font size='13' color='#FFFFFF'>☢"), nil)
		ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
		ui.addPopup(-2, 2, '', nil, 25, 310, 110)
		minesweeper.won()
	end
end

do 	-- TFM functions
	eventTextAreaCallback = function(id, name, callback)
		if name ~= player then
			return
		end

		if callback == 'show' then
			if isPressing then
				return minesweeper[id]:flag()
			else
				if not minesweeper[id].value then
					for idx, bomb in next, minesweeper.bombs do
						minesweeper[bomb]:show()
					end
					ui.addTextArea(-3, "<p align='center'><b><font size='30' color='#CED8FB'>\n\n\n\nVocê perdeu!", nil, 0, 0, 800, 400, 0xCB546B,0xCB546B,0.5)
					ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
					ui.addPopup(-2, 2, '', nil, 25, 310, 110)
				end
				return minesweeper[id]:show()
			end
		elseif callback == 'flag' then
			bombs = bombs + 1
			minesweeper[id].flagged = false
			ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
			ui.addPopup(-2, 2, '', nil, 25, 310, 110)
			return 	ui.updateTextArea(id, ("<p align='center'><a href='event:show'>\n\n\n"), nil)
		end
	end

	eventKeyboard = function(name, key, down)
		if down then 
			isPressing = true
		else
			isPressing = false
		end
	end

	eventPopupAnswer = function(id, name, callback)
		if name ~= player then
			return
		end

		local args = {}
		for arg in callback:gmatch('%d+') do
			if not (#args > 3) then
				table.insert(args, tonumber(arg))
			end
		end
		if (#args < 2) then
			start()
		else
			local x,y,m = table.unpack(args)
			return start(x,y,m)
		end
	end
end

start = function(x,y,m)
	local genTime = os.time()

	while #minesweeper > 1 do
		table.remove(minesweeper, 1)
	end

	local x = (x and x >= 5 and x <= 24) and x or 18
	local y = (y and y >= 5 and y <= 14) and y or 14
	local m = (m and m >= 1 and m < x*y/2) and m or math.floor((x*y*0.16))

	bombs = m

	minesweeper.add(x,y,m)

	local openTable = { }

	ui.addTextArea(0, "", nil, 0, 20, 800, 400, 0x6A7495, 0x6a7495)
	ui.addTextArea(-1, ("<p align='center'><b>MineSweeper!\n\n\n%d"):format(bombs), nil, 15, 30, 130, 356, 0x324650, 0x263051)
	ui.addPopup(-2, 2, '', nil, 25, 310, 110)

	for idx,v in ipairs(minesweeper) do
		if v.id then
			ui.addTextArea(v.id, ("<a href='event:show'>\n\n\n"), nil, 160 +((idx-1)%x)*26,30+math.floor((idx-1)/x)*26,18,18, 0x485273, 0x263051)
			if v.value and v.value == 0 then
				openTable[#openTable + 1] = v.id
			end
		end
	end

	if #openTable == 0 then
		return start()
	end

	local open = openTable[math.random(1,#openTable)]
	minesweeper[open]:show()

	print(('Tempo de geração: %d ms'):format(os.time() - genTime))
end

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.newGame('<C><P Ca="" /><Z><S><S L="800" o="596384" H="80" X="400" Y="410" T="12" P="0,0,.3,.2,,0,0,0" /><S P="0,0,.3,.2,,0,0,0" Y="110" L="10" H="10" c="4" i=",,1715aac7ab3.png" T="0" X="20" /><S /></S><D /><O /></Z></C>')

start()
