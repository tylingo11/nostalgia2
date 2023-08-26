local config = {
    storage = 10058,
    effect1 = 26,
	effect2 = 28,
    text1 = "Congratz, You have gained the Dragon Scale Addon!",
    text2 = "You already have this addon!",
    looktypeMale = 262,
	looktypeFemale = 263
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.storage) < 1 then
			player:addOutfitAddon(config.looktypeMale, 2)
			player:addOutfitAddon(config.looktypeFemale, 2)
        	player:say(config.text1, TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(config.effect1)
			player:getPosition():sendMagicEffect(config.effect2)
        	player:setStorageValue(config.storage, 1)
        	item:remove()
    	else
        	player:sendTextMessage(MESSAGE_INFO_DESCR, config.text2)
    	end
    return true
end