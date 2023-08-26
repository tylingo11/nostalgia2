local config = {
    storage = 10060,
    effect1 = 26,
	effect2 = 28,
    text1 = "Congratz, You have gained the Demon outfit and the first Adddon!",
    text2 = "You already have this outfit!",
    looktypeMale = 264,
	looktypeFemale = 265
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.storage) < 1 then
        	player:addOutfit(player:getSex() == PLAYERSEX_MALE and config.looktypeMale or config.looktypeFemale)
			player:addOutfitAddon(config.looktypeMale, 1)
			player:addOutfitAddon(config.looktypeFemale, 1)
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