function onStartup()
	math.randomseed(os.mtime())
	loadLampStates()
	
	db.query("TRUNCATE TABLE `players_online`")
	db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getDataInt(resultId, "account_id")
			db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getDataString(resultId, "reason")) .. ", " .. result.getDataLong(resultId, "banned_at") .. ", " .. result.getDataLong(resultId, "expires_at") .. ", " .. result.getDataInt(resultId, "banned_by") .. ")")
			db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Check house owner premium
	local resultId = db.storeQuery("SELECT `id`, `owner` FROM `houses` WHERE NOT `owner` = 0 AND (SELECT `premdays` FROM `accounts` WHERE (SELECT `account_id` FROM `players` WHERE `id` = `owner`) = `id`) = 0")
	if resultId ~= false then
		repeat
			local house = House(result.getDataInt(resultId, "id"))
			if house then
				house:setOwnerGuid(0)
			end
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Check house auctions
	local resultId = db.storeQuery("SELECT `id`, `highest_bidder`, `last_bid`, (SELECT `balance` FROM `players` WHERE `players`.`id` = `highest_bidder`) AS `balance` FROM `houses` WHERE `owner` = 0 AND `bid_end` != 0 AND `bid_end` < " .. os.time())
	if resultId ~= false then
		repeat
			local house = House(result.getDataInt(resultId, "id"))
			if house ~= nil then
				local highestBidder = result.getDataInt(resultId, "highest_bidder")
				local balance = result.getDataLong(resultId, "balance")
				local lastBid = result.getDataInt(resultId, "last_bid")
				if balance >= lastBid then
					db.query("UPDATE `players` SET `balance` = " .. (balance - lastBid) .. " WHERE `id` = " .. highestBidder)
					house:setOwnerGuid(highestBidder)
				end
				db.asyncQuery("UPDATE `houses` SET `last_bid` = 0, `bid_end` = 0, `highest_bidder` = 0, `bid` = 0 WHERE `id` = " .. house:getId())
			end
		until not result.next(resultId)
		result.free(resultId)
	end
	
	-- Remove murders that are more than 60 days old
	local resultId = db.storeQuery("SELECT * FROM `player_murders` WHERE `date` <= " .. os.time() - 60 * 24 * 60 * 60)
	if resultId ~= false then
		repeat
			local playerId = result.getDataInt(resultId, "player_id")
			local id = result.getDataLong(resultId, "id")
			
			db.asyncQuery("DELETE FROM `player_murders` WHERE `player_id` = " .. playerId .. " AND `id` = " .. id)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Remove deaths that are more than 30 days old
	local resultId = db.storeQuery("SELECT * FROM `player_deaths` WHERE `time` <= " .. os.time() - 30 * 24 * 60 * 60)
	if resultId ~= false then
		repeat
			local playerId = result.getDataInt(resultId, "player_id")
			local id = result.getDataLong(resultId, "id")
			
			db.asyncQuery("DELETE FROM `player_deaths` WHERE `player_id` = " .. playerId)
		until not result.next(resultId)
		result.free(resultId)
	end
end
