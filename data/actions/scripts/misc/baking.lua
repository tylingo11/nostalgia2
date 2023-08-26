local millstones = {1943, 1944, 1945, 1946}

local ovens = {
	2535, 2537, 2539, 2541, 3510
}

function onUse(player, item, fromPosition, target, toPosition)
	local itemId = item:getId()
	if itemId == 3603 then
		if target.type == 1 and target:getFluidType() == FLUID_WATER then
			item:remove(1)
			player:addItem(3604, 1)
			target:transform(target:getId(), FLUID_NONE)
			return true
		end
	elseif table.contains(millstones, target.itemid) then
		item:remove(1)
		player:addItem(3603, 1)
	elseif item:getId() == 3604 then
	if table.contains(ovens, target:getId()) then
		item:remove(1)
		Game.createItem(3600, 1, target:getPosition()) 
		return true
	end
end
	return false
end