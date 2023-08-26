local foodCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)

function Player.feed(self, food)
	local condition = self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		condition:setTicks(condition:getTicks() + (food * 1000))
	else
		local vocation = self:getVocation()
		if not vocation then
			return nil
		end

		foodCondition:setTicks(food * 1000)
		foodCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, vocation:getHealthGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, vocation:getHealthGainTicks() * 1000)
		foodCondition:setParameter(CONDITION_PARAM_MANAGAIN, vocation:getManaGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_MANATICKS, vocation:getManaGainTicks() * 1000)

		self:addCondition(foodCondition)
	end
	return true
end

function Player.getClosestFreePosition(self, position, extended)
	if self:getAccountType() >= ACCOUNT_TYPE_GOD then
		return position
	end
	return Creature.getClosestFreePosition(self, position, extended)
end

function Player.getDepotItems(self, depotId)
	return self:getDepotChest(depotId, true):getItemHoldingCount()
end

function Player.isNoVocation(self)
	return self:getVocation():getId() == 0
end

function Player.isSorcerer(self)
	return self:getVocation():getId() == 1 or self:getVocation():getId() == 5
end

function Player.isDruid(self)
	return self:getVocation():getId() == 2 or self:getVocation():getId() == 6
end

function Player.isPaladin(self)
	return self:getVocation():getId() == 3 or self:getVocation():getId() == 7
end

function Player.isKnight(self)
	return self:getVocation():getId() == 4 or self:getVocation():getId() == 8
end

function Player.isPremium(self)
	return self:getPremiumDays() > 0 or configManager.getBoolean(configKeys.FREE_PREMIUM)
end

function Player.sendCancelMessage(self, message)
	if type(message) == "number" then
		message = Game.getReturnMessage(message)
	end
	return self:sendTextMessage(MESSAGE_STATUS_SMALL, message)
end

function Player.isUsingOtClient(self)
	return self:getClient().os >= CLIENTOS_OTCLIENT_LINUX
end

function Player.sendExtendedOpcode(self, opcode, buffer)
	if not self:isUsingOtClient() then
		return false
	end

	local networkMessage = NetworkMessage()
	networkMessage:addByte(0x32)
	networkMessage:addByte(opcode)
	networkMessage:addString(buffer)
	networkMessage:sendToPlayer(self)
	networkMessage:delete()
	return true
end

APPLY_SKILL_MULTIPLIER = true
local addSkillTriesFunc = Player.addSkillTries
function Player.addSkillTries(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addSkillTriesFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

local addManaSpentFunc = Player.addManaSpent
function Player.addManaSpent(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addManaSpentFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

function Party:onJoin(player)
	return true
end

function Party:onLeave(player)
	return true
end

function Party:onDisband()
	return true
end

-- local config = {
-- 	{amount = 2, multiplier = 1.2},
-- 	{amount = 3, multiplier = 1.3},
-- 	{amount = 4, multiplier = 1.6}
-- }

-- function Party:onShareExperience(exp)
-- 	local sharedExperienceMultiplier = 1.2 -- 20% if the same vocation
-- 	local vocationsIds = {}
-- 	local vocationId = self:getLeader():getVocation():getBase():getId()
-- 	if vocationId ~= VOCATION_NONE then
-- 		table.insert(vocationsIds, vocationId)
-- 	end
-- 	for _, member in ipairs(self:getMembers()) do
-- 		vocationId = member:getVocation():getBase():getId()
-- 		if not table.contains(vocationsIds, vocationId) and vocationId ~= VOCATION_NONE then
-- 			table.insert(vocationsIds, vocationId)
-- 		end
-- 	end	
-- 	local size = #self:getMembers() + 1
-- 	for _, info in pairs(config) do
-- 		if size == info.amount then
-- 			sharedExperienceMultiplier = info.multiplier
-- 		end
-- 	end	
-- 	exp = (exp * sharedExperienceMultiplier) / (#self:getMembers() + 1)
-- 	return exp
-- end

