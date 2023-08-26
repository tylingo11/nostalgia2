local config = {
    storage = 10086,
    effect1 = 26,
	effect2 = 28,
    text1 = "Congratz, You have gained the Archer Outfit!",
    text2 = "You already have this outfit!",
	looktypeMale = 258,
	looktypeFemale = 259
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.storage) < 1 then
        	player:addOutfit(player:getSex() == PLAYERSEX_MALE and config.looktypeMale or config.looktypeFemale)
        	player:say(config.text1, TALKTYPE_MONSTER_SAY)
			player:setOutfit({lookType = (player:getSex() == PLAYERSEX_MALE and config.looktypeMale or config.looktypeFemale)})
			player:getPosition():sendMagicEffect(config.effect1)
			player:getPosition():sendMagicEffect(config.effect2)
        	player:setStorageValue(config.storage, 1)
        	item:remove()
    	else
        	player:sendTextMessage(MESSAGE_INFO_DESCR, config.text2)
    	end
    return true
end