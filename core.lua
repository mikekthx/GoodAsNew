local _, ns = ...
local L = ns.L

-- Get in here, Globals!
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetBagSlotFlag = C_Container.GetBagSlotFlag
local GetBackpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled
local NUM_TOTAL_EQUIPPED_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS
local ExcludeJunkSell = Enum.BagSlotFlags.ExcludeJunkSell
local Poor = Enum.ItemQuality.Poor
local GetItemInfo = C_Item.GetItemInfo

-- Shout it from the rooftops! or don't...
local function p(msg, cost, negative)
	if not GoodOptions.printMessage then return end
	if cost then
		print(msg, ns.formatMoney(cost, negative))
	else
		print(msg)
	end
end

-- Check the funds! The guild picks up the whole tab or none of it. No awkward "chip in, pal?" popups on our watch!
local function GuildCanCover(cost)
	local guildMode = GoodOptions.guildMode
	if not (guildMode == "always" or (guildMode == "raid" and IsInRaid())) or not CanGuildBankRepair() then
		return false
	end
	local credit = GetGuildBankWithdrawMoney()
	return cost <= GetGuildBankMoney() and (credit == -1 or cost <= credit)
end

-- Queue this up to ride along on Blizzard's own shout, or just holler it ourselves!
local pending
local originalAddMessage
local intercepting = false

-- Nothing left to catch, back to normal!
local function RestoreAddMessage()
	if intercepting then
		DEFAULT_CHAT_FRAME.AddMessage = originalAddMessage
		intercepting = false
	end
end

-- Steal Blizzard's own wording instead of playing translator ourselves!
local expectedPrefix = GENERIC_MONEY_GAINED_RECEIPT and GENERIC_MONEY_GAINED_RECEIPT:match("^(.-)%%s")
if expectedPrefix == "" then expectedPrefix = nil end

-- Dress down the wrapper so the numbers do the talking!
local function Gray(str)
	return GoodOptions.useColor and ("|cff9d9d9d" .. str .. "|r") or str
end

-- Caught it! Splice our total on and let it through.
local function InterceptedAddMessage(chatFrame, text, ...)
	if not intercepting or type(text) ~= "string" or not expectedPrefix or not text:find(expectedPrefix, 1, true) then
		return originalAddMessage(chatFrame, text, ...)
	end
	RestoreAddMessage()
	local parts = {}
	for _, entry in ipairs(pending) do
		parts[#parts + 1] = Gray(entry.msg) .. " " .. ns.formatMoney(entry.cost, entry.negative)
	end
	pending.merged = true
	pending = nil
	return originalAddMessage(chatFrame, text .. " " .. Gray("(") .. table.concat(parts, Gray(", ")) .. Gray(")"), ...)
end

-- Blizzard only speaks up if we walk out richer, and we won't know that till the door closes. Hold it all till then!
local function Announce(entries)
	if #entries == 0 then return end
	if GoodOptions.printMessage and GoodOptions.mergeMoneySummary and expectedPrefix then
		pending = pending or {}
		for _, entry in ipairs(entries) do
			pending[#pending + 1] = entry
		end
		if not intercepting then
			originalAddMessage = DEFAULT_CHAT_FRAME.AddMessage
			DEFAULT_CHAT_FRAME.AddMessage = InterceptedAddMessage
			intercepting = true
		end
	else
		for _, entry in ipairs(entries) do
			p(entry.msg, entry.cost, entry.negative)
		end
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

-- Tally up the trash before it hits the curb!
local function GetJunkValue()
	local total = 0
	for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		local excluded
		if bag == 0 then
			excluded = GetBackpackSellJunkDisabled()
		else
			excluded = GetBagSlotFlag(bag, ExcludeJunkSell)
		end
		if not excluded then
			for slot = 1, GetContainerNumSlots(bag) do
				local info = GetContainerItemInfo(bag, slot)
				if info and info.quality == Poor and not info.hasNoValue and not info.isLocked then
					local price = select(11, GetItemInfo(info.itemID))
					if price and price > 0 then
						total = total + price * info.stackCount
					end
				end
			end
		end
	end
	return total
end

-- Wallet's too thin? Say so!
local function WarnBroke()
	p("|cffff0000" .. L["Not enough money to automatically repair!"] .. "|r")
end

-- Fix us up if somebody can cover it! Hands back the receipt, or nil plus the bill if we came up short.
local function TryRepair()
	-- Gotta crunch the numbers before we open the wallet!
	local cost, repairAvailable = GetRepairAllCost()
	if cost <= 0 or not repairAvailable then return end -- Nothing broke, nothing to fix!
	-- See who's picking up the tab!
	local useGuild = GuildCanCover(cost)
	if not useGuild and cost > GetMoney() then
		return nil, cost
	end
	RepairAllItems(useGuild) -- My body is ready!
	if useGuild then
		return { msg = L["Repaired from the guild bank for"], cost = cost, negative = true }
	end
	return { msg = L["Repaired for"], cost = cost, negative = true }
end

-- Junk cash still in the mail? Hang tight till it lands!
local awaitingFunds = false

local f = CreateFrame("Frame")

-- Eyes on the wallet, and on the gear in case somebody else fixes it first!
local function StartWaiting()
	awaitingFunds = true
	f:RegisterEvent("PLAYER_MONEY")
	f:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
end

local function StopWaiting()
	awaitingFunds = false
	f:UnregisterEvent("PLAYER_MONEY")
	f:UnregisterEvent("UPDATE_INVENTORY_DURABILITY")
end

-- Let's get ready to rumble!
local function itsShowtime()
	local entries, junkTotal = {}, 0

	-- Get this junk outta my face!
	if GoodOptions.autoSell and C_MerchantFrame.IsSellAllJunkEnabled() and C_MerchantFrame.GetNumJunkItems() > 0 then
		junkTotal = GetJunkValue()
		C_MerchantFrame.SellAllJunkItems()
		if junkTotal > 0 then
			entries[#entries + 1] = { msg = L["Junk sold for"], cost = junkTotal }
		end
	end

	-- If this jabroni can't repair us (or we said not to), then fuhgeddaboudit!
	local broke = false
	if GoodOptions.autoRepair and CanMerchantRepair() and not (GoodOptions.useModKey and IsModifierKeyDown()) then
		local entry, bill = TryRepair()
		if entry then
			entries[#entries + 1] = entry
		elseif bill then
			-- The junk money hasn't hit our pockets yet. If it'll cover the bill, wait for it!
			if junkTotal > 0 and bill <= GetMoney() + junkTotal then
				StartWaiting()
			else -- Pocket lint detected. We’re broke, baby!
				broke = true
			end
		end
	end

	-- Last, but not least!
	Announce(entries)
	if broke then
		WarnBroke()
	end
	-- Cleaned up, patched up, and ready to roll!
end

-- Same peek at the wallet Blizzard takes, so we know if it'll bother shouting!
local startingMoney

f:SetScript("OnEvent", function(_, event)
	if event == "MERCHANT_SHOW" then
		StopWaiting()
		startingMoney = GetMoney()
		itsShowtime()
	elseif event == "PLAYER_MONEY" or event == "UPDATE_INVENTORY_DURABILITY" then
		-- Changed our mind about repairs mid-wait? Then we're done here!
		if not GoodOptions.autoRepair then
			StopWaiting()
			return
		end
		-- Cha-ching! Might come in a few drips, so keep checking till we can pay (or somebody beat us to it).
		local entry, bill = TryRepair()
		if not bill then
			StopWaiting()
			if entry then
				Announce({ entry })
			end
		end
	else -- MERCHANT_CLOSED
		if pending then
			local thisVisit = pending
			if startingMoney and GetMoney() <= startingMoney then
				-- Walked out no richer? Blizzard's staying quiet, so it's all us!
				RestoreAddMessage()
				FlushPending(thisVisit)
				pending = nil
			else
				-- Give Blizzard's line a couple seconds to strut in before we throw in the towel!
				C_Timer.After(2, function()
					if pending == thisVisit then
						RestoreAddMessage()
						FlushPending(thisVisit)
						pending = nil
					end
				end)
			end
		end
		startingMoney = nil
		-- Door's shut and the cash never showed. No repair today!
		if awaitingFunds then
			StopWaiting()
			WarnBroke()
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")
