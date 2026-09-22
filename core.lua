local _, ns = ...
local L = ns.L
local O = GoodOptions

-- Get in here, Globals!
local GetContainerItemID = C_Container.GetContainerItemID
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetBagSlotFlag = C_Container.GetBagSlotFlag
local GetBackpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local ExcludeJunkSell = Enum.BagSlotFlags.ExcludeJunkSell
local GetItemInfo = C_Item.GetItemInfo

-- Shout it from the rooftops! or don't...
local function p(msg, cost)
	if O.printMessage then
		print(msg, ns.formatMoney(cost))
	end
end

-- Check the funds!
local function CheckRepairStatus(cost)
	-- Time to peek inside the piggy banks!
	local cash, hoard = GetMoney(), GetGuildBankWithdrawMoney()
	if (O.guildMode == "always" or (O.guildMode == "raid" and IsInRaid())) and
	  CanGuildBankRepair() and
	  cost <= GetGuildBankMoney() and
	  (cost <= hoard or hoard == -1) then
		return true, true
	elseif cost <= cash then
		return true, nil
	end
end

-- Will Blizzard's own vendor money line actually show up anywhere? If the player's
-- turned off "Money" under Chat Settings, or turned off our own messages, it won't --
-- so there's nothing to merge into and we should just print our own line like before.
local function MoneyMessageWillShow()
	if not O.printMessage or not O.mergeMoneySummary then return false end
	local list = DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.messageTypeList
	if not list then return false end
	for _, messageType in pairs(list) do
		if messageType == "MONEY" then return true end
	end
	return false
end

-- Queue this up to ride along on Blizzard's own line, or just say it ourselves.
local pending
local function Announce(msg, cost)
	if MoneyMessageWillShow() then
		pending = pending or {}
		pending[#pending + 1] = { msg = msg, cost = cost }
	else
		p(msg, cost)
	end
end

-- Blizzard's client fires a real CHAT_MSG_MONEY line summarizing the whole vendor visit.
-- Rather than suppress it, ride our own totals along on the end of it -- a filter callback
-- can return (false, newText, ...restOfOriginalArgs) to rewrite a message instead of just
-- discarding it (confirmed in ChatFrameFilters.lua's ProcessFilters). If Announce() never
-- queued anything for this event, leave it completely untouched -- money gained from
-- something other than our own sale/repair (a manual sale, a trade, looted gold) should
-- never be rewritten.
--
-- Each chat frame/tab listening for "Money" processes this event independently and calls
-- this filter separately, all synchronously within the same tick. Clearing `pending` the
-- instant the first one reads it would leave every other frame with Blizzard's unmerged
-- text -- so the clear is deferred a tick instead, letting every frame see the same queued
-- totals while still guaranteeing a later, unrelated money event (which can only arrive on
-- some future tick) starts from a clean slate.
ChatFrameUtil.AddMessageEventFilter("CHAT_MSG_MONEY", function(_, _, text, ...)
	if not pending then return false end
	local parts = {}
	for _, entry in ipairs(pending) do
		parts[#parts + 1] = entry.msg .. " " .. ns.formatMoney(entry.cost)
	end
	-- Mark this queue consumed *before* the deferred clear runs, so MERCHANT_CLOSED can
	-- tell "already merged, just waiting on the timer" apart from "never got a chat frame
	-- to merge into" if it fires in that gap -- otherwise it'd print our fallback lines on
	-- top of the line we just merged into.
	pending.merged = true
	local thisVisit = pending
	C_Timer.After(0, function()
		if pending == thisVisit then pending = nil end
	end)
	return false, text .. " (" .. table.concat(parts, ", ") .. ")", ...
end)

-- Let's get ready to rumble!
local function itsShowtime()
	-- Get this junk outta my face!
	if C_MerchantFrame.IsSellAllJunkEnabled() then
		local total = 0
		for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			local excluded
			if bag == 0 then
				excluded = GetBackpackSellJunkDisabled()
			else
				excluded = GetBagSlotFlag(bag, ExcludeJunkSell)
			end
			if not excluded then
				local slots = GetContainerNumSlots(bag)
				if slots > 0 then
					for slot = 1, slots do
						local id = GetContainerItemID(bag, slot)
						if id then
							local _, _, quality, _, _, _, _, _, _, _, price = GetItemInfo(id)
							if quality == 0 and price and price > 0 then
								local info = GetContainerItemInfo(bag, slot)
								total = total + price * (info and info.stackCount or 1)
							end
						end
					end
				end
			end
		end
		C_MerchantFrame.SellAllJunkItems()
		if total > 0 then Announce(L["Junk items sold for"], total) end
	end

	-- If this jabroni can't repair us then fuhgeddaboudit!
	if not CanMerchantRepair() then return end

	-- Gotta crunch the numbers before we open the wallet!
	local cost, repairAvailable = GetRepairAllCost()
	if cost <= 0 or not repairAvailable then return end -- Nothing broke, nothing to fix!

	local canRepair, spender = CheckRepairStatus(cost)

	-- Last, but not least!
	if IsModifierKeyDown() and O.useModKey then -- Meh! I'll repair later I guess!
		return
	elseif canRepair then -- My body is ready!
		if spender then
			Announce(L["Repaired from the guild bank for"], cost)
		else
			Announce(L["Repaired for"], cost)
		end
		RepairAllItems(spender)
	else -- Pocket lint detected. We’re broke, baby!
		p("|cffff0000" .. L["Not enough money to automatically repair!"] .. "|r")
	end
	-- Cleaned up, patched up, and ready to roll!
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(_, event)
	if event == "MERCHANT_SHOW" then
		itsShowtime()
	elseif pending then -- MERCHANT_CLOSED
		if not pending.merged then -- CHAT_MSG_MONEY never showed up to carry our totals
			for _, entry in ipairs(pending) do
				p(entry.msg, entry.cost)
			end
		end
		pending = nil
	end
end)
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")

-- Merchant's already yappin'? Let’s hit 'em early!
if MerchantFrame:IsVisible() then itsShowtime() end
