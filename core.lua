local _, ns = ...
local L = ns.L
local O = GoodOptions

-- Get in here, Globals!
local GetContainerItemID = GetContainerItemID
local GetContainerNumSlots = GetContainerNumSlots
local GetItemInfo = GetItemInfo
local ShowMerchantSellCursor = ShowMerchantSellCursor
local UseContainerItem = UseContainerItem

-- Shout it from the rooftops! or don't...
local function p(msg, cost)
	if O.printMessage then
		print(msg, ns.formatMoney(cost))
	end
end

-- Let's get ready to rumble!
local function itsShowtime()
	-- Get this junk outta my face!
	local total = 0
	local itemCache = {}
	for bag = 0, NUM_BAG_SLOTS do
		local slots = GetContainerNumSlots(bag)
		if slots > 0 then
			for slot = 1, slots do
				local id = GetContainerItemID(bag, slot)
				if id and id ~= 6196 then -- Don't waste my time with that cudgel!
					local quality, price
					if itemCache[id] then
						quality, price = unpack(itemCache[id])
					else
						local _, _, q, _, _, _, _, _, _, _, p = GetItemInfo(id)
						quality, price = q, p
						itemCache[id] = { quality, price }
					end

					if quality == 0 and price and price > 0 then
						ShowMerchantSellCursor(1)
						UseContainerItem(bag, slot)
						total = total + price
					end
				end
			end
		end
	end
	if total > 0 then p(L["Junk items sold for"], total) end

	-- If this jabroni can't repair us then fuhgeddaboudit!
	if not CanMerchantRepair() then return end

	-- Gotta crunch the numbers before we open the wallet!
	local cost, spender = GetRepairAllCost(), nil
	local function canRepair()
		-- Time to peek inside the piggy banks!
		local cash, hoard = GetMoney(), GetGuildBankWithdrawMoney()
		if (O.guildRepair or O.guildOnlyRaid and GetNumRaidMembers() ~= 0) and
		  CanGuildBankRepair() and
		  cost <= GetGuildBankMoney() and
		  (cost <= hoard or hoard == -1) then
			spender = 1
			return true
		elseif cost <= cash then
			return true
		end
	end

	-- Last, but not least!
	if IsModifierKeyDown() and O.useModKey then -- Meh! I'll repair later I guess!
		return
	elseif cost > 0 and canRepair() then -- My body is ready!
		if spender then
			p(L["Repaired from the guild bank for"], cost)
		else
			p(L["Repaired for"], cost)
		end
		RepairAllItems(spender)
	else -- Pocket lint detected. We’re broke, baby!
		p("|cffff0000" .. L["Not enough money to automatically repair!"] .. "|r")
	end
	-- Cleaned up, patched up, and ready to roll!
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", itsShowtime)
f:RegisterEvent("MERCHANT_SHOW")

-- Merchant's already yappin'? Let’s hit 'em early!
if MerchantFrame:IsVisible() then itsShowtime() end
