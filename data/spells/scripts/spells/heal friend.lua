local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, maglevel)
	local c = 13.1
    local min = ((level/ 3) + (maglevel/2)) * c * 0.9
    local max = ((level/3) + (maglevel/2)) * c * 1.1
	
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	local manaSelfCost = 35
	if creature:isPlayer() and variant:getNumber() == creature:getId() then
		creature:addManaSpent(manaSelfCost)
		creature:addMana(-manaSelfCost)
		return combat:execute(creature, variant)
	else
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return combat:execute(creature, variant)
	end
end