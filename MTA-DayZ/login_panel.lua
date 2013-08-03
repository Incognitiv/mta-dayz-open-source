function passwordHandler(player, oldpassword, newpassword)
	local account = getPlayerAccount(player)
	if account then
		if isGuestAccount(account) then
			outputChatBox("You must be logged in to change your password.", player)
			return
		end
		local playerName = getPlayerName(player)
		local password_check = getAccount(playerName, oldpassword)
		if (password_check ~= false) then
			if string.len(newpassword) >= 5 then
				setAccountPassword(account, newpassword)
				triggerClientEvent(player, "hidePasswordWindow", getRootElement())
			else
				outputChatBox("Your new password must be at least 5 characters long!", player)
			end
		else
			outputChatBox("Old password invalid.", player)
		end
	end
end

function logOutPlayer()
	logOut(source)
end

function loginHandler(player, username, password)
	local account = getAccount(username, password)
	if account ~= false then
		if logIn(player, account, password) == true then
			outputChatBox("If you want to change your password, use /changepw", player)
			triggerClientEvent (player, "hideLoginWindow", getRootElement())
			--triggerEvent ("loggedIn", player)
			trigerEvent("onPlayerDayZLogin", getRootElement(), username, password, player)
		elseif isGuestAccount(getPlayerAccount(player)) == false then
			triggerClientEvent(player, "alreadyLogged", getRootElement())
		else
			triggerClientEvent(player, "unknownError", getRootElement())
		end
	else
		triggerClientEvent(player, "loginWrong", getRootElement())
	end
end

function registerHandler(player, username, password)
	local account = getAccount(username, password)
	if account ~= false then
		triggerClientEvent(player, "registerTaken", getRootElement())
	else
		account = addAccount(username, password)
		if logIn(player, account, password) == true then
			outputChatBox("If you want to change your password, use /changepw", player)
			triggerClientEvent(player, "hideLoginWindow", getRootElement())
			trigerEvent("onPlayerDayZRegister", getRootElement(), username, password, player)
		else
			triggerClientEvent(player, "unknownError", getRootElement())
		end
	end
end

addEvent("logOutPlayer", true)
addEvent("submitChangepw", true)
addEvent("submitLogin", true)
addEvent("submitRegister", true)
addEventHandler("logOutPlayer", root, logOutPlayer)
addEventHandler("submitChangepw", root, passwordHandler)
addEventHandler("submitLogin", root, loginHandler)
addEventHandler("submitRegister", root, registerHandler)