local root = getRootElement()
addEventHandler("onPlayerLogin", root, function()
  triggerClientEvent("onRollMessageStart", getRootElement(), getPlayerName(source) .. " #FFFFFFzalogowal sie!", 255, 255, 255, "join")
end)
