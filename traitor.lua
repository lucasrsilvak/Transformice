-- Last Update: 2020

local playersDictionary = {}	-- Info about the player
local playersList 	= {}	-- List of alive players
local traitorList 	= {}	-- List of alive traitors
local allPlayers	= {}	-- List of allPlayers alive or not
local killTable 	= {}	-- List of players to be killed
local lastGameInfo 	= {}	-- Info about the last game

local suspectsNeed 	= 3		-- This will be changed on the script run
local PPT 		= 6		-- Players per traitor
local keys = {9, 32, 72, 79}		-- Keys
local gameCurrently	= false 	-- If a game is running then its changed to true
local someoneWon	= false		-- No one won so it is false
local rangeToCatch 	= 60		-- Range between two players that can means death

local lang = {
	br = {
		beingSuspected  = "<V>%s</V> está sendo suspeito de ser um <R>traidor</R> (%d/%d)",
		biteAgain 	= "<J>Você pode morder novamente :)</J>",
		bitePlayer 	= "Você mordeu <PT>%s</PT>, ele morrerá em 3 segundos. Você poderá morder novamente em 10s.",
		cooldownInfo 	= "Acalme-se!",
		helpMessage	= "<J>#traitor é um jogo criado por Impuredeath. Atalhos: \nTAB ↹: Cancelar uma suspeita.\nO: Disponibiliza os stats da última partida\nH: Disponibiliza as informações sobre o jogo.</J>",
		ifNotBite 	= "Se você não morder ninguém em %d segundos você morrerá!",
		infoLastGame 	= "<font face='Lucida Console' size='12'><J>NomeDoJogador#1234 "..string.rep(' ', 7).. "- SE - SC - PM - TM</J></font>",
		infoLastTitle	= "<font face='Lucida Console' size='12'><J>Informações da última partida</J></font>",
		killedPlayer 	= "Ah não! <V>%s</V> matou o inocente <PT>%s</PT> :(",
		killedTraitor 	= "<V>%s</V> matou o traidor <R>%s</R>",
		notFound 	= "%s não foi encontrado.",
		notFoundMouse	= "Não foi possível detectar um jogador.",
		playerDied 	= "<PT>%s</PT> foi morto!",
		playerInfo 	= "Você é <PT>inocente</PT>. Procure pelos <R>traidores</R>",
		playerWin 	= "<PT>Os inocentes VENCERAM!</PT>",
		suspectedOne 	= "Você já suspeitou de alguém",
		suspectedLots 	= "Você fez muitas suspeitas erradas",
		suspiciousForIt = "Você ganhou uma acusação por participar da morte do <PT>inocente %s</PT>",
		traitorDied 	= "O traidor <R>%s</R> morreu!",
		traitorInfo 	= "Você é um <R>traidor</R>. Mate jogadores com a barra de espaço. Você pode usar \"!tc seutexto\" para falar com outros jogadores.",
		traitorWin 		= "Os <R>traidores</R> (<R>%s</R>) venceram!",
		welcome			= "<J>Bem-vindo ao #traitor, use a tecla H para mais informações.</J>"
	},
	en = {
		beingSuspected  = "<V>%s</V> is being suspected of being a <R>traitor</R> (%d/%d)",
		biteAgain 	= "<J>You can bite again :)</J>",
		bitePlayer 	= "You bit <PT>%s</PT>, %s will die in 3 seconds. You can bite in 10s again.",
		cooldownInfo 	= "Calm down!",
		helpMessage	= "<J>#traitor is a game by Impuredeath. Hotkey: \nTAB ↹: Cancel a suspect.\nO: Show the last match information\nH: Show the game information</J>",
		ifNotBite 	= "You have %d to kill someone before you die!",
		infoLastGame 	= "<font face='Lucida Console' size='12'><J>PlayerName#1234 "..string.rep(' ', 10).. "- WS - CS - PK - TK</J></font>",
		infoLastTitle	= "<font face='Lucida Console' size='12'><J>Last game information</J></font>",
		killedPlayer 	= "Oh noes! <V>%s</V> killed the innocent <PT>%s</PT> :(",
		killedTraitor 	= "<V>%s</V> killed the traitor <R>%s</R>",
		notFound 	= "%s not found in the room.",
		notFoundMouse	= "Could not find a player.",
		playerDied 	= "<PT>%s</PT> has been killed!",
		playerInfo 	= "You are <PT>innocent</PT>. Find out the <R>traitors</R>",
		playerWin 	= "<PT>The innocents WON!</PT>",
		suspectedOne 	= "You already suspected someone",
		suspectedLots 	= "You did lots of wrong suspects",
		suspiciousForIt = "You brought suspicion for yourself by taking part of killing the <PT>innocent %s</PT>",
		traitorDied 	= "The traitor <R>%s</R> died!",
		traitorInfo 	= "You are a <R>traitor</R>. Kill players with spacebar. You can chat with other traitors using \"!tc yourtext\"",
		traitorWin 	= "The <R>traitors</R> (<R>%s</R>) won the game!",
		welcome 	= "<J>Welcome to #traitor, use the hotkey H for more information.</J>"
	},
}

translate = function(p, k)
    local cmm = tfm.get.room.playerList[p] and tfm.get.room.playerList[p].community or "en"
    cmm = lang[cmm] and cmm or "en"
    return lang[cmm][k] or "ERROR"
end

translatedRoomMsg = function(message, ...)
    for name in next, tfm.get.room.playerList do 
    	if (...) then
    		tfm.exec.chatMessage(translate(name, message):format(...), name)
    	else
        	tfm.exec.chatMessage(translate(name, message), name)
    	end
    end 
end

local maps = {'@3998291','@3766247','@3776043','@282322','@3803927','@3783232','@297547','@2872064','@740834','@3829257','@4017512','@310723','@2890428','@3790965','@2872064','@312253', '@3769399', '@3057710', '@3829257','@3825129','@3797815','@3977032', '@3803927', '@740834', '@816611','@3818481', '@3816936', '@3817515', '@3804014', '@3773092', '@3804484', '@3816869', '@3827096', '@3829794', '@3842098', '@3815556', '@3846078', '@3793772', '@3858736','@1707434', '@3890688', '@764203', '@3914126', '@4017512', '@4058198', '@3941983'}

local players = {
	new = function(name)
		return {
			name 		= name,

			dead 		= false,
			atRisk		= false,
			traitor 	= false,
			warned		= true,
			suspected	= false,

			needKillNumber 	= 0,
			suspectBy 	= 0,
			wrongSuspects 	= 0,
			correctSuspects = 0,
			playersKilled 	= 0,
			traitorsKilled 	= 0,

			lastBite	= os.time()-10000,
			needBite	= os.time()+10000,

			suspectedName = '',
			suspectedTable = {}
		}
	end,

	killedTraitor = function(self, bool)
		if bool then
			self.traitorsKilled = self.traitorsKilled + 1
		else
			self.playersKilled = self.playersKilled + 1
		end
	end,

	sucessfulSuspect = function(self, bool)
		if bool then
			self.correctSuspects = self.correctSuspects + 1
		else
			self.wrongSuspects = self.wrongSuspects + 1
		end
	end,

	biteSomeone = function(self)
		self.needKillNumber 	= 0
		self.needBite 		= os.time()+10000
		self.lastBite 		= os.time()
		self.warned	  	= false
		self.playersKilled 	= self.playersKilled + 1
	end,

	suspectedBySomeone = function(self, suspectorName)
		self.suspectBy = self.suspectBy + 1
		tfm.exec.setPlayerScore(self.name, self.suspectBy)

		if suspectorName then	-- If a suspector exist then
			table.insert(self.suspectedTable, suspectorName)
			translatedRoomMsg('beingSuspected', self.name, self.suspectBy, suspectsNeed)
		end

		if self.suspectBy >= suspectsNeed then
			self.atRisk = true
			tfm.exec.setNameColor(self.name, 0xCB546B)
		end
	end,

	suspectedSomeone = function(self, name)
		if not self.suspected then
			self.suspectedName = name
			self.suspected = true
	 	end
	end,

	removeMySuspect = function(self, removedName)
		for i=1,#self.suspectedTable do
			if self.suspectedTable[i].name:lower() == removedName:lower() then
				table.remove(self.suspectedTable, i)
				self.suspectBy = self.suspectBy - 1
				tfm.exec.setPlayerScore(self.name, self.suspectBy)
				if self.suspectBy < suspectsNeed then
					self.atRisk = false
					tfm.exec.setNameColor(self.name, 0xC2C2DA)
					break
				end
			end
		end
	end,

	removeSuspect = function(self)
		self.suspectorName = ''
		self.suspected = false
	end,
}

local nameMeta = {
	__index = players
}

tdigit = function(num)
	return num > 10 and num or '0' .. num
end

math.hypo = function(x1, y1, x2, y2)
    return ((x2-x1)^2 + (y2-y1)^2)^0.5
end

clearStats = function(name)
	if playersDictionary[name] and not playersDictionary[name].dead then -- If player isn't at the game then we should ignore it
		
		playersDictionary[name].dead = true -- Changing the alive stats of the player
		tfm.exec.setPlayerScore(name, 0)
		
		if #playersDictionary[name].suspectedTable > 0 then
			for k,v in next, playersDictionary[name].suspectedTable do
				v:removeSuspect()
			end
		end

		if playersDictionary[name].traitor then -- If was a traitor died
			translatedRoomMsg('traitorDied', name)
			for k,v in next, traitorList do 
				if v.name == name then -- Check the traitor for remove it
					table.remove(traitorList, k)
					break 
				end
			end

			if #traitorList == 0 and not someoneWon then	-- Check if we don't have more alive traitors
				translatedRoomMsg('playerWin')
				for k,v in next, playersList do
					tfm.exec.giveCheese(v.name)
					tfm.exec.playerVictory(v.name)
					someoneWon = true		-- Someone won so nobody can win again in that round
				end
				tfm.exec.setGameTime(2)
			end
		else -- If was a player dead
			translatedRoomMsg('playerDied', name)
			for k,v in next, playersList do
				if v.name == name then 
					table.remove(playersList, k)
					break 
				end
			end

			if #playersList == 0 and not someoneWon then -- Check if we don't have more alive players
				local playerName = {}
				for k,v in next, traitorList do
					table.insert(playerName, v.name)
				end
				local traitorsString = table.concat(playerName, ", ")

				translatedRoomMsg('traitorWin', traitorsString)
				for k,v in next, traitorList do
					tfm.exec.giveCheese(v.name)
					tfm.exec.playerVictory(v.name)
					someoneWon = true
				end
				tfm.exec.setGameTime(2)
			end
		end
	end
end

detectPlayer = function(command)
	local x, name = 0
	for k,v in next, allPlayers do
		if v.name:lower():match(command:lower()) == command:lower() then
			x = x + 1
			name = v
		end
	end
	if x > 1 or x == 0 then
		return 'error'
	end
	return name
end

eventChatCommand = function(player, command)
	if playersDictionary[player] then -- If its a player then
		local commandWords = {}

		for word in command:gmatch("%a+") do table.insert(commandWords, word) end
		if commandWords[1] == 'tc' and playersDictionary[player].traitor then
			for k,v in next, traitorList do
				tfm.exec.chatMessage((('<R>[%s]</R> <N>%s</N>'):format(player, command)):gsub('tc ',''), v.name)
			end
		else
			if not playersDictionary[player].suspected and not (playersDictionary[player].wrongSuspects >= 3) then
				local name = detectPlayer(command)
				if name ~= 'error' then
					if not name.dead then
						playersDictionary[player]:suspectedSomeone(name)
						name:suspectedBySomeone(playersDictionary[player])
					end
				else
					tfm.exec.chatMessage((translate(player, "notFound"):format(command)), player)
				end
			elseif playersDictionary[player].suspected then
				tfm.exec.chatMessage(translate(player, "suspectedOne"), player)
			else	
				tfm.exec.chatMessage(translate(player, "suspectedLots"), player)
			end
		end
	end
end

eventNewGame = function()
	tfm.exec.setGameTime(240)

	do -- Reset the lastGameInfo and set the last game info again
		lastGameInfo = {}
		
		for k,v in next, allPlayers do
			tfm.exec.setPlayerScore(v.name, 0)
			tfm.exec.setNameColor(v.name, 0xC2C2DA)
			table.insert(lastGameInfo, v)
		end
	end

	do -- Reset all the variables of the game and set new players and traitors

		playersDictionary, playersList, traitorList, allPlayers, killTable = {}, {}, {}, {}, {}
		id = 0

		gameCurrently, someoneWon = false, false -- Game isn't running

		table.foreach(tfm.get.room.playerList, eventNewPlayer)
		local traitorsCount = math.ceil(#playersList/PPT)
		suspectsNeed = math.ceil(#playersList/2) < 3 and math.ceil(#playersList/2) or 3

		for i=1,traitorsCount do
			local traitorID = math.random(#playersList) -- Defines a traitor
			local name = playersList[traitorID]
			name.traitor = true
			table.insert(traitorList, name)
			table.remove(playersList, traitorID)
		end

		do
			for _,player in next, playersList do -- Gives info about the player
				tfm.exec.chatMessage(translate(player.name, "playerInfo"), player.name)
			end
			for _,traitor in next, traitorList do -- Same to above
				tfm.exec.chatMessage(translate(traitor.name, "traitorInfo"), traitor.name)
			end
		end

		gameCurrently = true -- Game running again
	end
end

eventNewPlayer = function(name)
	if not gameCurrently then -- If the game is running then we can't add the player for avoid bugs
		for _,keys in next, keys do
			system.bindKeyboard(name, keys, true, true)
		end
		system.bindMouse(name)

		local name = players.new(name)
		setmetatable(name, nameMeta)
		table.insert(playersList, name)
		table.insert(allPlayers, name)
		playersDictionary[name.name] = name
	else
		tfm.exec.chatMessage(translate(name, "welcome"), name)
	end
end

eventKeyboard = function(name, key, pressing, x, y)

	if key == 32 then -- If spacebar is pressed
		if playersDictionary[name] then -- If its a traitor or a normal player
			for k,v in next, allPlayers do
				if playersDictionary[v.name].atRisk and not playersDictionary[v.name].dead then -- If someone is at risk
					if math.hypo(x, y, tfm.get.room.playerList[v.name].x, tfm.get.room.playerList[v.name].y) <= rangeToCatch and playersDictionary[v.name].traitor and not (name == v.name) then -- Verify if the one at risk is a traitor
						v.needBite = os.time()+200000
						tfm.exec.killPlayer(v.name)
						translatedRoomMsg('killedTraitor', name, v.name)
						playersDictionary[name]:killedTraitor(true)

					elseif math.hypo(x, y, tfm.get.room.playerList[v.name].x, tfm.get.room.playerList[v.name].y) <= rangeToCatch and not (name == v.name) then -- If not a traitor and at the range
						tfm.exec.killPlayer(v.name)
						translatedRoomMsg('killedPlayer', name, v.name)
						playersDictionary[name]:killedTraitor(false)
					end
				end
			end
		end

		if playersDictionary[name].traitor then	-- If its a traitor pressing
			if playersDictionary[name].lastBite < os.time()-10000 then -- If he lastBite was some time ago
				for k,v in next, playersList do
					if math.hypo(x, y, tfm.get.room.playerList[v.name].x, tfm.get.room.playerList[v.name].y) <= rangeToCatch and playersDictionary[name].lastBite < os.time()-10000 then -- Check again the lastBite and his position
						local gender = tfm.get.room.playerList == 1 and 'she' or 'he'
						tfm.exec.chatMessage(((translate(name, "bitePlayer")):format(v.name, gender)), name)
						local arg = {name = v.name, time = os.time()}
						playersDictionary[name]:biteSomeone()
						table.insert(killTable, arg)
						break
					end
				end
			else
				tfm.exec.chatMessage(translate(name, "cooldownInfo"), name)
			end
		end

	elseif key == 9 then -- If TAB is pressed
		if playersDictionary[name].suspected then -- If suspected someone
			local suspected = playersDictionary[name].suspectedName
			playersDictionary[name]:removeSuspect()
			suspected:removeMySuspect(name)
		end
	elseif key == 72 then -- If H is pressed
		tfm.exec.chatMessage(translate(name, "helpMessage"), name)
	elseif key == 79 then -- If O is pressed
		tfm.exec.chatMessage(translate(name, "infoLastTitle"), name)
		tfm.exec.chatMessage(translate(name, "infoLastGame"), name)

		for k,v in next, lastGameInfo do
			local color = ''
			if v.traitor then color = '#CB546B' else color = '#2EBA7E' end
			tfm.exec.chatMessage((("<font face='Lucida Console' color='%s' size='12'>%s "..string.rep(' ', 25 - #v.name).. "- %s - %s - %s - %s</font>"):format(color, v.name, tdigit(v.wrongSuspects), tdigit(v.correctSuspects), tdigit(v.playersKilled), tdigit(v.traitorsKilled))), name)
		end
	end
end

eventLoop = function(ct, rt)

	for k,v in next, traitorList do
		if v.lastBite < os.time()-10000 and not v.warned then
			tfm.exec.chatMessage(translate(v.name, "biteAgain"), v.name)
			v.warned = true
		end
		if v.needBite < os.time()-(10000*v.needKillNumber) then
			tfm.exec.chatMessage(((translate(v.name, "ifNotBite")):format((6-v.needKillNumber)*10)), v.name)
			v.needKillNumber = v.needKillNumber + 1
			if v.needKillNumber >= 6 then
				v.needBite = os.time()+200000
				tfm.exec.killPlayer(v.name)
			end
		end
	end

	if #killTable ~= 0 then -- Kill a player if someone is at the table
		local remove, canRemove = 0, false
		for k,v in next, killTable do
			if v.time < os.time()-3000 then
				tfm.exec.killPlayer(v.name)
				remove, canRemove = k, true
			end
		end
		if canRemove then table.remove(killTable, remove) end
	end

	if rt <= 0 then
		tfm.exec.newGame(maps[math.random(#maps)])
	end
end

eventMouse = function(player, x, y)
	if not playersDictionary[player].suspected and not (playersDictionary[player].wrongSuspects >= 3) then
		for k,v in next, allPlayers do
			if math.hypo(x, y, tfm.get.room.playerList[v.name].x, tfm.get.room.playerList[v.name].y) <= rangeToCatch and not playersDictionary[v.name].dead then
				playersDictionary[player]:suspectedSomeone(v)
				playersDictionary[v.name]:suspectedBySomeone(playersDictionary[player])
				break
			elseif k == #allPlayers then
				tfm.exec.chatMessage(translate(player, "notFoundMouse"), player)
			end
		end
	elseif playersDictionary[player].suspected then
		tfm.exec.chatMessage(translate(player, "suspectedOne"), player)
	else
		tfm.exec.chatMessage(translate(player, "suspectedLots"), player)
	end
end

eventPlayerDied = function(name)

	tfm.exec.setPlayerScore(name, 0)

	if playersDictionary[name].atRisk then
		playersDictionary[name].atRisk = false
		for k,v in next, playersDictionary[name].suspectedTable do
			if playersDictionary[name].traitor then
				v:sucessfulSuspect(true)
			else
				tfm.exec.chatMessage((translate(v.name, "suspiciousForIt"):format(name)), v.name)
				v:suspectedBySomeone()
				v:sucessfulSuspect(false)
			end
		end
	end
	clearStats(name)
end

eventPlayerLeft = function(name)
	for k,v in next, allPlayers do
		if v.name == name then
			table.remove(allPlayers, k)
		end
	end
	clearStats(name)
end

system.disableChatCommandDisplay(nil)
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAutoTimeLeft()
tfm.exec.newGame(maps[math.random(#maps)])
