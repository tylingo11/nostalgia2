local config = {
    storage = 10047,
    effect1 = 26,
	effect2 = 28,
    text1 = "Congratz, You have gained the Crown Addon!",
    text2 = "You already have this addon!",
    looktypeMale = 267,
	looktypeFemale = 266
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.storage) < 1 then
			player:addOutfitAddon(config.looktypeMale, 1)
			player:addOutfitAddon(config.looktypeFemale, 1)
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