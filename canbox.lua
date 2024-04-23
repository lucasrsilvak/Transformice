-- Last Update: 03/03/2020

tfm.exec.disableAutoScore()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAfkDeath()

local mapList = {'@6154355','@6703703'}
local remove = {}
local despawn

local set = {0,0,0,0,0,6}

function eventNewGame()
	local xml = tfm.get.room.xmlMapInfo.xml
	local obj = xml:match('spawn=".-"')

	local i = 0
	for arg in obj:gmatch('%d+') do
		i = i + 1
		if arg then
			print(arg)
			set[i] = arg
		end
	end

	tfm.exec.setGameTime(300)	
	ui.setMapName('#canbox')

	remove = {}
end

function eventLoop(ct, rt)
	local t={1,2,3,4,6,7,17,23,24,32,33,34,35,39,40,45,46,54,60,61,62,63,65,68,69,80,85,89,90,95,96,97}
	if math.random(0,10) <= 9 then
		local tp = t[math.random(#t)]
		--spawn="x,y,angle,velX, velY, despawn"
		local id = tfm.exec.addShamanObject(tp, set[1], set[2], set[3], set[4], set[5], math.random() < 0.5)
		table.insert(remove,{os.time(),id,0})
	end

	for i,item in ipairs(remove) do
		if tfm.get.room.objectList[item[2]].vx == 0 then
			item[3] = item[3] + 1
		end
		if item[1] <= os.time()-set[6]*10000 or item[3] == 3 then
			tfm.exec.removeObject(item[2])
			table.remove(remove,i)
		end
    end

    if rt <= 1 then
    	tfm.exec.newGame(mapList[math.random(#mapList)])
    end
end

function eventPlayerDied(p)
	tfm.exec.respawnPlayer(p)
end

function eventPlayerWon(p)
	tfm.exec.respawnPlayer(p)
end


function eventNewPlayer(p)
	tfm.exec.respawnPlayer(p)
end

function eventPlayerWon(name)
   tfm.exec.setPlayerScore(name, 100, true)
end

tfm.exec.newGame(mapList[1])
