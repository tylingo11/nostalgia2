function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    Game.saveGameState()
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server is now saved.")
end