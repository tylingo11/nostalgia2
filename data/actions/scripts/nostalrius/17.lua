function onUse(player, item, fromPosition, target, toPosition)
	if item:getId() == 2773 and Game.isItemThere({x = 33222, y = 31671, z = 13},430) and Game.isItemThere ({x = 33223, y = 31671, z = 13},430) and Game.isItemThere ({x = 33224, y = 31671, z = 13},430) and Game.isItemThere ({x = 33225, y = 31671, z = 13},430) and Game.isItemThere ({x = 33220, y = 31659, z = 13},1772) then 
		item:transform(2772, 1)
		item:decay()
		Game.removeItemOnMap({x = 33220, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33221, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33222, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33223, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33224, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33219, y = 31659, z = 13}, 1772)
		Game.removeItemOnMap({x = 33219, y = 31657, z = 13}, 1772)
		Game.removeItemOnMap({x = 33221, y = 31657, z = 13}, 1772)
		Game.removeItemOnMap({x = 33220, y = 31661, z = 13}, 1772)
		Game.removeItemOnMap({x = 33222, y = 31661, z = 13}, 1772)
		Game.createMonster("Demon", {x = 33224, y = 31659, z = 13})
		Game.createMonster("Demon", {x = 33223, y = 31659, z = 13})
		Game.createMonster("Demon", {x = 33219, y = 31657, z = 13})
		Game.createMonster("Demon", {x = 33221, y = 31657, z = 13})
		Game.createMonster("Demon", {x = 33220, y = 31661, z = 13})
		Game.createMonster("Demon", {x = 33222, y = 31661, z = 13})
		doRelocate({x = 33222, y = 31671, z = 13},{x = 33219, y = 31659, z = 13})
		doRelocate({x = 33223, y = 31671, z = 13},{x = 33220, y = 31659, z = 13})
		doRelocate({x = 33224, y = 31671, z = 13},{x = 33221, y = 31659, z = 13})
		doRelocate({x = 33225, y = 31671, z = 13},{x = 33222, y = 31659, z = 13})
		Game.sendMagicEffect({x = 33219, y = 31659, z = 13}, 11)
		Game.sendMagicEffect({x = 33220, y = 31659, z = 13}, 11)
		Game.sendMagicEffect({x = 33221, y = 31659, z = 13}, 11)
		Game.sendMagicEffect({x = 33222, y = 31659, z = 13}, 11)
	end
	return true
end