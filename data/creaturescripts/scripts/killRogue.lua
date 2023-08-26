function onKill(creature, target)
	if not target:isMonster() or target:getMaster() or target:isPlayer() then
        return true
    end
	if target:getName():lower() ~= "rogue warlock" then
		return true
	end
	
	for attacker, _ in pairs(target:getDamageMap()) do
		local attackerPlayer = Player(attacker)
		if not attackerPlayer then
			return true
		end

		if attackerPlayer:getStorageValue(10037) <= 1 then
			attackerPlayer:setStorageValue(10037, 2)
			attackerPlayer:say("Congratz! you have defeat the Rogue Warlock. Report to The Mysterious Wizard", TALKTYPE_MONSTER_SAY)
			attackerPlayer:getPosition():sendMagicEffect(26)
			attackerPlayer:getPosition():sendMagicEffect(28)
		end
	end
	return true
end