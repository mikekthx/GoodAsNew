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
local function p(msg, cost, negative)
	if O.printMessage then
		print(msg, ns.formatMoney(cost, negative))
	end
end

-- Check the funds!
local function CheckRepairStatus(cost)
	-- Time to peek inside the piggy banks!
	local cash, credit = GetMoney(), GetGuildBankWithdrawMoney()
	if (O.guildMode == "always" or (O.guildMode == "raid" and IsInRaid())) and
		CanGuildBankRepair() and
		cost <= GetGuildBankMoney() and
		(cost <= credit or credit == -1) then
		return true, true
	elseif cost <= cash then
		return true, nil
	end
end

-- Queue this up to ride along on Blizzard's own shout, or just holler it ourselves!
local pending
local originalAddMessage

-- Nothing left to catch, back to normal!
local function RestoreAddMessage()
	if originalAddMessage then
		DEFAULT_CHAT_FRAME.AddMessage = originalAddMessage
		originalAddMessage = nil
	end
end

-- Steal Blizzard's own wording instead of playing translator ourselves!
local expectedPrefix = GENERIC_MONEY_GAINED_RECEIPT and GENERIC_MONEY_GAINED_RECEIPT:match("^(.-)%%s")
if expectedPrefix == "" then expectedPrefix = nil end

-- Dress down the wrapper so the numbers do the talking!
local function Gray(str)
	return O.useColor and ("|cff9d9d9d" .. str .. "|r") or str
end

-- Caught it! Splice our total on and let it through.
local function InterceptedAddMessage(chatFrame, text, ...)
	if type(text) ~= "string" or not expectedPrefix or not text:find(expectedPrefix, 1, true) then
		return originalAddMessage(chatFrame, text, ...)
	end
	local realAddMessage = originalAddMessage
	RestoreAddMessage()
	local parts = {}
	for _, entry in ipairs(pending) do
		parts[#parts + 1] = Gray(entry.msg) .. " " .. ns.formatMoney(entry.cost, entry.negative)
	end
	pending.merged = true
	pending = nil
	return realAddMessage(chatFrame, text .. " " .. Gray("(") .. table.concat(parts, Gray(", ")) .. Gray(")"), ...)
end

local function Announce(msg, cost, negative)
	if O.printMessage and O.mergeMoneySummary and expectedPrefix then
		pending = pending or {}
		pending[#pending + 1] = { msg = msg, cost = cost, negative = negative }
		if not originalAddMessage then
			originalAddMessage = DEFAULT_CHAT_FRAME.AddMessage
			DEFAULT_CHAT_FRAME.AddMessage = InterceptedAddMessage
		end
	else
		p(msg, cost, negative)
	end
end

-- Nobody came to carry it? Fine, we'll shout it ourselves!
local function FlushPending(visit)
	if not visit.merged then
		for _, entry in ipairs(visit) do
			p(entry.msg, entry.cost, entry.negative)
		end
	end
end

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
		if total > 0 then Announce(L["Junk sold for"], total) end
	end

	-- If this jabroni can't repair us then fuhgeddaboudit!
	if not CanMerchantRepair() then return end

	-- Gotta crunch the numbers before we open the wallet!
	local cost, repairAvailable = GetRepairAllCost()
	if cost <= 0 or not repairAvailable then return end -- Nothing broke, nothing to fix!

	-- See who's picking up the tab!
	local canRepair, spender = CheckRepairStatus(cost)

	-- Last, but not least!
	if IsModifierKeyDown() and O.useModKey then -- Meh! I'll repair later I guess!
		return
	elseif canRepair then -- My body is ready!
		if spender then
			Announce(L["Repaired from the guild bank for"], cost, true)
		else
			Announce(L["Repaired for"], cost, true)
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
		-- Give Blizzard's line a couple seconds to strut in before we throw in the towel!
		local thisVisit = pending
		C_Timer.After(2, function()
			if pending == thisVisit then
				RestoreAddMessage()
				FlushPending(thisVisit)
				pending = nil
			end
		end)
	end
end)
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")

-- Merchant's already yappin'? Let’s hit 'em early!
if MerchantFrame:IsVisible() then itsShowtime() end
