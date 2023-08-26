local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, false)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, fightMode)
	local base = 80
	local variation = 20
	local formula = 3 * player:getMagicLevel() + (2 * player:getLevel())
	local damage = formula * base / 100
	damage = damage * attack / 25
    return -damage - variation, -damage + variation
end


combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(monsterType, variant)
	local manaCost = monsterType:getLevel() * 4
	if monsterType:getMana() < manaCost and not monsterType:hasFlag(PlayerFlag_HasInfiniteMana) then
		monsterType:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		monsterType:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	monsterType:addManaSpent(manaCost)
	monsterType:addMana(-manaCost)
    return combat:execute(monsterType, variant)
end