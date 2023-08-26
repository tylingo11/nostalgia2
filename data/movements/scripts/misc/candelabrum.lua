function onRemoveItem(moveItem, item, position, cid)
	local itemPosition = item:getPosition()
	if itemPosition:getDistance(position) > 0 then
		item:transform(2912, 1)
		item:decay()
	end
	return true
end