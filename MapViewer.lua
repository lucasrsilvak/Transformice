// Last Update: 2020

local cat 		= 'P22'	-- Se não quiser especificar apague o texto entre as aspas
local inverse 	= false -- Mude para true caso queira inverter a ordem
local tempo 	= 3 	-- Determina o tempo em segundos para a troca de mapas

local lsmap = [[

Substitua essa linha pelo seu /lsmap

]]

local lastMap = os.time()
local queue, catQueue = {}, {}

do
	if not cat or cat == '' then
		for map in lsmap:gmatch('%@%d+') do
			table.insert(queue, map)
		end
	else
		for map, localcat in lsmap:gmatch ('(@%d+).-(P%d+)') do
			if localcat == cat then
				table.insert(queue, map)
			end
		end
	end
end

eventLoop = function()
	if #queue ~= 0 and lastMap < os.time()-(tempo*1000) then
		lastMap = os.time()
		local actualMap
		if not inverse then
			actualMap = queue[1]
			tfm.exec.newGame(queue[1])
			table.remove(queue, 1)
		else
			actualMap = queue[#queue]
			tfm.exec.newGame(queue[#queue])
			table.remove(queue, #queue)
		end
		print(('Atual: %s, restantes: %d'):format(actualMap, #queue))
		tfm.exec.setGameTime(3)		
	end
end

math.time = function(sec)
	local min = math.floor(sec/60) 
	min = min > 10 and min or 0 .. min
	local sec = math.floor(sec%60) 
	sec = sec > 10 and sec or 0 .. sec
	return min, sec
end

print(('Tempo esperado: %s:%s'):format(math.time(#queue*tempo)))
tfm.exec.setGameTime(tempo)
tfm.exec.disableAutoNewGame()
