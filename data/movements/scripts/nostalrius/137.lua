function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then 
		creature:getPlayer():setStorageValue(272,1)
		item:getPosition():sendMagicEffect(13)
	end
end
