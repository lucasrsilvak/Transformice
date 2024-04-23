-- Last Update 2020

local colors = {
	[2] = {0xefe3d9,'#726960',38},
	[4] = {0xebdfc7,'#726960',38},
	[8] = {0xf1af78,'#faf4f0',38},
	[16] = {0xf59463, '#faf4f0',28},
	[32] = {0xf47c5b, '#faf4f0',28},
	[64] = {0xf75d3c, '#faf4f0',28},
	[128] = {0xebcf70, '#faf4f0',22},
	[256] = {0xebcb5f, '#faf4f0', 22},
	[512] = {0xeec650, '#ffffff', 22},
	[1024] = {0xeec440, '#ffffff', 16},
	[2048] = {0xecc400, '#ffffff', 16},
	[4096] = {0x1, '#ffffff', 16},
}
local keys  = {0,1,2,3}

local players = {}
local playerList = {}

function updateScore(player)
	local data = players[player]
	local score = 0
  	for i=1,16 do
    	if data.tiles[i].occupied then
    		score = score + math.floor(data.tiles[i].tier^1.2)
    		if data.tiles[i].tier == 2048 and data.firstVictory then
    			ui.addTextArea(30, "<p align='center'><font color='#faf4f0'><font size='30'>\n\n\n<a href='event:close'>You Win!", player, 260, 60, 280, 280, 0xdec36d, 0xecc400, 0.5, true)
    			data.firstVictory = false
    		end
    	end
	end
	data.score = score
	ui.addTextArea(29, (("<b><p align='center'><font color='#726960'><font size='14'>Score: %s</font>"):format(data.score)), player, 410, 360, 130, 20, 0xb6a89c, 0xb6a89c, 1, true)
	tfm.exec.setPlayerScore(player, data.score)
end

function add2048(player)
  	local tilesOccupied = 0
  	local idx = 0
  	local pTiles = players[player].tiles
  	for i=1,16 do
  		if pTiles[i].occupied then
  	  		tilesOccupied = tilesOccupied + 1
      		if tilesOccupied == 16 then
				return
    		end
		else
			repeat idx = math.random(1,16) until pTiles[idx].occupied == false
		break end
	end
	tileSpawn = {2,2,2,2,4}; pTiles[idx].tier = tileSpawn[math.random(#tileSpawn)] 
	ui.addTextArea(pTiles[idx].id, (("<p align='center'><font color='%s'><font size='%s'>%d</font>"):format(colors[pTiles[idx].tier][2],colors[pTiles[idx].tier][3], pTiles[idx].tier)), player, 270+pTiles[idx].l*70, 70+pTiles[idx].c*70, 50, 50, colors[pTiles[idx].tier][1], colors[pTiles[idx].tier][1], 1, true)
	pTiles[idx].occupied = true
	updateScore(player)
end

function addTiles(player)
	local count = 0
	for c=0,3 do
    	for l=0,3 do
    		count = count + 1
    		players[player].tiles[count] = {id = count, tier = 0, occupied = false, l = l, c = c}
    	end
	end
end

function draw2048(player)
	ui.addTextArea(17, "", player, 260, 60, 280, 280, 0xc7bbaf, 0xc7bbaf, 1, true)

	for i=0,4 do
	    ui.addTextArea(18+i, "", player, 260+i*70, 60, 2, 280, 0xb6a89c, 0xb6a89c, 1, true)
	    ui.addTextArea(23+i, "", player, 260, 60+i*70, 280, 2, 0xb6a89c, 0xb6a89c, 1, true)
		ui.addTextArea(28, "<b><p align='center'><font color='#726960'><font size='14'><a href='event:reset'>Reset</font>", player, 260, 360, 130, 20, 0xb6a89c, 0xb6a89c, 1, true)
	end
	add2048(player); add2048(player)
	updateScore(player)
end

function merge2048(increasing, horizontal, player)
	local tiles = players[player].tiles
	if increasing then
		a,b,c = 1,16,1 -- for values
		d = 1 -- horizontal if value
		function fakemath(x,y)
	    	return x - y
	    end
	    function compare(x)
	    	return x >= 5
	    end
	    function _compare(x)
	    	return x <= 4
	    end
  	else
	    a,b,c = 16,1,-1 -- for values
	    d = 0 -- horizontal if value
	    function fakemath(x,y)
	    	return x + y
	    end
	    function compare(x)
	    	return x <= 12
	    end
	    function _compare(x)
	    	return x >= 13
	    end
  	end
  
	local invalid = 0
	local valid = 0

	for i=a,b,c do
	    if tiles[i].occupied then
	    	valid = valid + 1
	    	local z = i
	    	local merge2048 
	    	if horizontal then
	     		if i % 4 ~= d then
	        		local y = 0
	          		repeat 
	            		y = y + 1
	            		z = fakemath(i,y)
	          		until z % 4 == d or tiles[z].occupied
	          		if tiles[z].occupied then 
	            		if tiles[z].tier == tiles[i].tier then
	               			tiles[z].tier = tiles[z].tier*2
	               			if not colors[tiles[z].tier*2] then
	         	  				colors[tiles[z].tier*2] = {0x000001, 'ffffff', 14}
	               			end
	          				merge2048 = true
	           			else
	    	 				z = fakemath(z,-1)
	          				merge2048 = false
	          				if tiles[z].occupied then
	              				invalid = invalid + 1
              				end
	           			end
	     			end
		      	else 
	    	    	invalid = invalid + 1
	        	end
    		else
	        	if compare(i) then
	          		local y = 0
	          		repeat 
	            		y = y + 4
	        			z = fakemath(i,y)
		        	until _compare(z) or tiles[z].occupied
		          	if tiles[z].occupied then 
		            	if tiles[z].tier == tiles[i].tier then
		            	    tiles[z].tier = tiles[z].tier*2
		            	    merge2048 = true
		            	else
		            		z = fakemath(z,-4)
		            		merge2048 = false
		            		if tiles[z].occupied then
		                		invalid = invalid + 1
		              		end
		            	end
		          	end
        		else
        			invalid = invalid + 1
       			end
    		end
	    	if merge2048 then
		        tiles[i].occupied = false
		        ui.removeTextArea(i,player)
		        ui.addTextArea(z, (("<p align='center'><font color='%s'><font size='%s'>%d</font>"):format(colors[tiles[z].tier][2], colors[tiles[z].tier][3], tiles[z].tier)), player, 270+tiles[z].l*70, 70+tiles[z].c*70, 50, 50, colors[tiles[z].tier][1], colors[tiles[z].tier][1], 1, true)
	      	else
		        tiles[z].tier = tiles[i].tier
		        tiles[i].occupied = false
		        tiles[z].occupied = true
		        ui.removeTextArea(i,player)
		        ui.addTextArea(z, (("<p align='center'><font color='%s'><font size='%s'>%d</font>"):format(colors[tiles[z].tier][2], colors[tiles[z].tier][3], tiles[z].tier)), player, 270+tiles[z].l*70, 70+tiles[z].c*70, 50, 50, colors[tiles[z].tier][1], colors[tiles[z].tier][1], 1, true)
	      	end 
   		end
	end
	if valid > invalid then add2048(player) end
	updateScore(player)
end

function eventNewPlayer(player)
	if not players[player] then
		players[player] = {
			name = player,
			score = 0,
			first = true,
			tiles = {}
		}
		addTiles(player)
		draw2048(player)
		table.insert(playerList, players[player])
	end
	for k,v in next, keys do
		system.bindKeyboard(player, v, true, true)
	end
end

function eventKeyboard(player, keys)
	if keys == 0 then
   		return merge2048(true, true, player)
	elseif keys == 1 then
		return merge2048(true, false, player)
	elseif keys == 2 then
		return merge2048(false, true, player)
	elseif keys == 3 then
		return merge2048(false, false, player)
	end
end

function eventTextAreaCallback(id, player, key)
	if key == 'reset' then
	    players[player].firstVictory = true
	    players[player].tiles = {}; addTiles(player)
	    draw2048(player)
	elseif key == 'close' then
		ui.removeTextArea(id, player)
	end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
