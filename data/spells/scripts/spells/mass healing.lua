local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local healMonsters = true

function onTargetCreature(creature, target)
	if not healMonsters then
		local master = target:getMaster()
		if target:isMonster() and not master or master and master:isMonster() then
			return true
		end
	end
	
	local player = creature:getPlayer()
	local level = player:getLevel()
	local maglevel = player:getMagicLevel()
	local c = 7.86

    local min = ((level/ 3) + (maglevel/2)) * c * 0.9
	local max = ((level/ 3) + (maglevel/2)) * c * 1.1

	doTargetCombatHealth(creature, target, COMBAT_HEALING, min, max, CONST_ME_NONE)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end