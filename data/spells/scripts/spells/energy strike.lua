local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_TELEPORT)

function onGetFormulaValues(player, level, maglevel)
	local c = 2.7
    local min = ((level/ 3) + (maglevel/2)) * c * 0.9
    local max = ((level/3) + (maglevel/2)) * c * 1.1
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end