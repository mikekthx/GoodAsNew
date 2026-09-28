local addonName, ns = ...
local L = ns.L

-- It's about to go down, so grab your globals!
local tinsert = table.insert
local tconcat = table.concat

-- If no one's home, we're settin' the rules!
local defaults = {
	autoSell = true,
	autoRepair = true,
	guildMode = "off", -- "off", "always", "raid"
	useModKey = false,
	printMessage = true,
	mergeMoneySummary = true,
	currencyStyle = "coin", -- "short", "full", "coin"
	useColor = true,
}

-- Don't trust a stranger's picks!
local validChoices = {
	guildMode = { off = true, always = true, raid = true },
	currencyStyle = { short = true, full = true, coin = true },
}

-- Get these coins in order!
function ns.GetCoinText(amount, full, colored)
	local g = floor(amount / 10000)
	local s = floor((amount % 10000) / 100)
	local c = amount % 100
	local txt = full and 2 or 1
	local gc = colored and "|cffffd700" or ""
	local sc = colored and "|cffc7c7cf" or ""
	local cc = colored and "|cffeda55f" or ""
	local rc = colored and "|r" or ""

	local parts = {}
	if g > 0 then tinsert(parts, format("%d%s%s%s", g, gc, L.g[txt], rc)) end
	if s > 0 then tinsert(parts, format("%d%s%s%s", s, sc, L.s[txt], rc)) end
	if c > 0 then tinsert(parts, format("%d%s%s%s", c, cc, L.c[txt], rc)) end

	return tconcat(parts, " ")
end

-- However you wanna see it, we’ll dress it up nice!
function ns.formatMoney(cost, negative)
	local style = GoodOptions.currencyStyle or "coin"
	if type(cost) ~= "number" or cost < 0 then return "" end
	local sign = negative and "-" or ""
	if style == "coin" then
		local _, fontHeight = DEFAULT_CHAT_FRAME:GetFont()
		local coinText = sign .. C_CurrencyInfo.GetCoinTextureString(cost, fontHeight or 14)
		if GoodOptions.useColor then
			return "|cffffffff" .. coinText .. "|r"
		end
		return coinText
	else
		return sign .. ns.GetCoinText(cost, style == "full", GoodOptions.useColor)
	end
end

-- Saved settings don't show up until the client's done loading us, so hold your horses!
EventUtil.ContinueOnAddOnLoaded(addonName, function()
	-- Unpack the saved stuff, and if it's a mess in there, tidy up!
	GoodOptions = type(GoodOptions) == "table" and GoodOptions or {}
	for k, v in pairs(defaults) do
		if type(GoodOptions[k]) ~= type(v) then
			GoodOptions[k] = v
		end
	end
	for k, choices in pairs(validChoices) do
		if not choices[GoodOptions[k]] then
			GoodOptions[k] = defaults[k]
		end
	end

	-- Roll out the red carpet, here comes the star of the show!
	local category, layout = Settings.RegisterVerticalLayoutCategory("Good As New")

	-- A few little helpers to cut down on the paperwork!
	local function Header(name)
		layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(name))
	end

	local function Checkbox(variable, key, name, tooltip)
		local setting = Settings.RegisterAddOnSetting(category, variable, key, GoodOptions,
			Settings.VarType.Boolean, name, defaults[key])
		return Settings.CreateCheckbox(category, setting, tooltip), setting
	end

	local function Dropdown(variable, key, name, options, tooltip)
		local setting = Settings.RegisterAddOnSetting(category, variable, key, GoodOptions,
			Settings.VarType.String, name, defaults[key])
		return Settings.CreateDropdown(category, setting, options, tooltip)
	end

	-- First up, taking out the trash!
	Header(L["Junk"])
	Checkbox("GOODASNEW_AUTO_SELL", "autoSell", L["Sell junk automatically"],
		L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."])

	-- Patch me up, doc!
	Header(L["Repairs"])
	local repairInit, repairSetting = Checkbox("GOODASNEW_AUTO_REPAIR", "autoRepair", L["Repair gear automatically"],
		L["Repairs all of your gear when you visit a vendor that can repair."])
	local function IsRepairing() return repairSetting:GetValue() end

	-- Stay classy, guild dropdown!
	local function GetGuildModeOptions()
		local container = Settings.CreateControlTextContainer()
		container:Add("off", L["Off"])
		container:Add("always", L["All the time"])
		container:Add("raid", L["Only in a raid group"])
		return container:GetData()
	end
	Dropdown("GOODASNEW_GUILD_MODE", "guildMode", L["Repair with guild bank funds"], GetGuildModeOptions,
		L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."])
		:SetParentInitializer(repairInit, IsRepairing)

	-- For when you wanna take control!
	Checkbox("GOODASNEW_USE_MOD_KEY", "useModKey", L["Hold Modifier Key to prevent repairing"],
		L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."])
		:SetParentInitializer(repairInit, IsRepairing)

	-- Talk to me, baby! or not...
	Header(L["Chat"])
	local printInit, printSetting = Checkbox("GOODASNEW_PRINT_MESSAGE", "printMessage", L["Show messages in chat"],
		L["Prints how much your junk sold for and what repairs cost."])
	local function IsPrinting() return printSetting:GetValue() end

	-- Two receipts are one too many!
	Checkbox("GOODASNEW_MERGE_MONEY_SUMMARY", "mergeMoneySummary", L["Combine with Blizzard's money summary at vendors"],
		L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."])
		:SetParentInitializer(printInit, IsPrinting)

	-- Time to let the people choose! Show 'em a sample before they buy.
	local sample = 123456
	local function GetCurrencyStyleOptions()
		local container = Settings.CreateControlTextContainer()
		container:Add("short", L["Short text"], ns.GetCoinText(sample, false, true))
		container:Add("full", L["Full text"], ns.GetCoinText(sample, true, true))
		container:Add("coin", L["Coin icons"], C_CurrencyInfo.GetCoinTextureString(sample, 14)).warning =
			L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."]
		return container:GetData()
	end
	Dropdown("GOODASNEW_CURRENCY_STYLE", "currencyStyle", L["Currency display style:"], GetCurrencyStyleOptions,
		L["How money amounts are written in chat messages."])
		:SetParentInitializer(printInit, IsPrinting)

	-- Bold AND beautiful!
	Checkbox("GOODASNEW_USE_COLOR", "useColor", L["Use color formatting"],
		L["Colors the money amounts in chat messages."])
		:SetParentInitializer(printInit, IsPrinting)

	-- And now... the main event!
	Settings.RegisterAddOnCategory(category)

	-- Knock knock, it's the settings panel!
	SLASH_GOODASNEW1 = "/goodasnew"
	SLASH_GOODASNEW2 = "/gan"
	SlashCmdList.GOODASNEW = function()
		Settings.OpenToCategory(category:GetID())
	end
end)
