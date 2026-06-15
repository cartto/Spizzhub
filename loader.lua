local games = {
    [155615604] = true;
}

function importFromWeb(folder, file)
  local main = "https://raw.githubusercontent.com/cartto/Spizzhub/refs/heads/main/"
	local universal = "https://raw.githubusercontent.com/cartto/Spizzhub/refs/heads/main/main.lua"
 
    if folder then
        return main .. "/" .. tostring(folder) .. "/" .. tostring(file) .. ".lua"
    else
        return universal
    end
end


local code = importFromWeb("games", game.PlaceId)
if games[game.PlaceId] then
    loadstring(game:HttpGet(tostring(code), true))()
else
    code = importFromWeb(nil)
    loadstring(game:HttpGet(tostring(code), true))()
end
