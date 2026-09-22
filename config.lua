local _, ns = ...
local L = ns.L

-- It's about to go down, so grab your globals!
local tinsert = table.insert
local tconcat = table.concat

-- If no one's home, we're settin' the rules!
GoodOptions = type(GoodOptions) == "table" and GoodOptions or {}
local defaults = {
	guildMode = "off", -- "off", "always", "raid"
	useModKey = false,
	printMessage = true,
	mergeMoneySummary = true,
	currencyStyle = "coin", -- "short", "full", "coin"
	useColor = true,
}
for k, v in pairs(defaults) do
	if GoodOptions[k] == nil then
		GoodOptions[k] = v
	end
end

-- Don't trust a stranger's guildMode!
local validGuildModes = { off = true, always = true, raid = true }
if not validGuildModes[GoodOptions.guildMode] then
	GoodOptions.guildMode = defaults.guildMode
end

-- Get these coins in order!
function ns.GetCoinText(amount)
	local g = floor(amount / 10000)
	local s = floor((amount % 10000) / 100)
	local c = amount % 100
	local txt = GoodOptions.currencyStyle == "full" and 2 or 1
	local gc = GoodOptions.useColor and "|cffffd700" or ""
	local sc = GoodOptions.useColor and "|cffc7c7cf" or ""
	local cc = GoodOptions.useColor and "|cffeda55f" or ""
	local rc = GoodOptions.useColor and "|r" or ""

	local parts = {}
	if g > 0 then tinsert(parts, format("%d%s%s%s", g, gc, L.g[txt], rc)) end
	if s > 0 then tinsert(parts, format("%d%s%s%s", s, sc, L.s[txt], rc)) end
	if c > 0 then tinsert(parts, format("%d%s%s%s", c, cc, L.c[txt], rc)) end

	return tconcat(parts, " ")
end

-- However you wanna see it, we’ll dress it up nice!
function ns.formatMoney(cost)
	local style = GoodOptions.currencyStyle or "coin"
	if type(cost) ~= "number" or cost < 0 then return "" end
	if style == "coin" then
		return GetCoinTextureString(cost)
	else
		return ns.GetCoinText(cost)
	end
end

-- Roll out the red carpet, here comes the star of the show!
local category = Settings.RegisterVerticalLayoutCategory("Good As New")

-- Stay classy, guild dropdown!
local guildModeSetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_GUILD_MODE", "guildMode",
	GoodOptions, Settings.VarType.String, L["Repair with guild bank funds"], defaults.guildMode)
local function GetGuildModeOptions()
	local container = Settings.CreateControlTextContainer()
	container:Add("off", L["Off"])
	container:Add("always", L["All the time"])
	container:Add("raid", L["Only in a raid group"])
	return container:GetData()
end
Settings.CreateDropdown(category, guildModeSetting, GetGuildModeOptions)

-- For when you wanna take control!
local modKeySetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_USE_MOD_KEY", "useModKey",
	GoodOptions, Settings.VarType.Boolean, L["Hold Modifier Key to prevent repairing"], defaults.useModKey)
Settings.CreateCheckbox(category, modKeySetting)

-- Talk to me, baby! or not...
local messageSetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_PRINT_MESSAGE", "printMessage",
	GoodOptions, Settings.VarType.Boolean, L["Show messages in chat"], defaults.printMessage)
Settings.CreateCheckbox(category, messageSetting)

-- Two receipts are one too many!
local mergeMoneySummarySetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_MERGE_MONEY_SUMMARY", "mergeMoneySummary",
	GoodOptions, Settings.VarType.Boolean, L["Combine with Blizzard's money summary at vendors"], defaults.mergeMoneySummary)
Settings.CreateCheckbox(category, mergeMoneySummarySetting, L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to separate messages if Blizzard's money messages are turned off in your chat settings."])

-- Time to let the people choose.
local currencySetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_CURRENCY_STYLE", "currencyStyle",
	GoodOptions, Settings.VarType.String, L["Currency display style:"], defaults.currencyStyle)
local function GetCurrencyStyleOptions()
	local container = Settings.CreateControlTextContainer()
	container:Add("short", L["Short text"])
	container:Add("full", L["Full text"])
	container:Add("coin", L["Coin icons"], L["Display Warning"] .. "\n" .. L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."])
	return container:GetData()
end
Settings.CreateDropdown(category, currencySetting, GetCurrencyStyleOptions)

-- Bold AND beautiful!
local colorSetting = Settings.RegisterAddOnSetting(category, "GOODASNEW_USE_COLOR", "useColor",
	GoodOptions, Settings.VarType.Boolean, L["Use color formatting"], defaults.useColor)
Settings.CreateCheckbox(category, colorSetting)

-- And now... the main event!
Settings.RegisterAddOnCategory(category)
