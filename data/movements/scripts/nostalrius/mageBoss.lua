local destination = {
	newPos = Position(33268, 31835, 9),
	returnPos = Position(33281, 31847, 8)
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	if player:getStorageValue(10037) == 1 then
		player:teleportTo(destination.newPos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:setDirection(DIRECTION_SOUTH)
		player:teleportTo(destination.returnPos)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not prepared yet.")
	end
	return true
end