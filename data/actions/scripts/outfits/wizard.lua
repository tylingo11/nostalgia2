local config = {
    storage = 10038,
    effect1 = 26,
	effect2 = 28,
    text1 = "Congratz, You have gained the Wizard outfit!",
    text2 = "You already have this outfit!",
    looktypeMale = 260,
	looktypeFemale = 261
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.storage) < 1 then
        	player:addOutfit(player:getSex() == PLAYERSEX_MALE and config.looktypeMale or config.looktypeFemale)
        	player:say(config.text1, TALKTYPE_MONSTER_SAY)
			player:setOutfit({lookType = (player:getSex() == PLAYERSEX_MALE and config.looktypeMale or config.looktypeFemale)})
			player:getPosition():sendMagicEffect(config.effect1)
			player:getPosition():sendMagicEffect(config.effect2)
        	player:setStorageValue(config.storage, 2)
        	item:remove()
    	else
        	player:sendTextMessage(MESSAGE_INFO_DESCR, config.text2)
    	end
    return true
end