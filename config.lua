local addon, ns = ...
local L = ns.L

-- It's about to go down, so grab your globals!
local _G = _G
local CreateFrame = CreateFrame
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_SetSelectedID = UIDropDownMenu_SetSelectedID
local UIDropDownMenu_SetText = UIDropDownMenu_SetText
local tinsert = table.insert
local tconcat = table.concat

-- If no one's home, we're settin' the rules!
GoodOptions = GoodOptions or {}
local defaults = {
	guildRepair = false,
	guildOnlyRaid = false,
	useModKey = false,
	printMessage = true,
	guildMode = "always", -- "always", "raid"
	currencyStyle = "short", -- "short", "full", "coin"
	useColor = true,
}
for k, v in pairs(defaults) do
	if GoodOptions[k] == nil then
		GoodOptions[k] = v
	end
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
	if not cost or cost < 0 or type(cost) ~= "number" then return "" end
	if style == "coin" then
		return GetCoinTextureString(cost)
	else
		return ns.GetCoinText(cost)
	end
end

-- Roll out the red carpet, here comes the star of the show!
local OP = CreateFrame("Frame", addon.."OptionsPanel", UIParent)
OP.name = "Good As New"

-- Show me what you've got!
OP:SetScript("OnShow", function(self)
	if self.initialized then return end
	self.initialized = true

	-- Up top! Loud and proud!
	local title = OP:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("Good As New")

	-- Check that box, baby, and let the guild foot the bill!
	local guildCheck = CreateFrame("CheckButton", addon.."GuildCheck", OP, "InterfaceOptionsCheckButtonTemplate")
	guildCheck:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
	_G[guildCheck:GetName() .. "Text"]:SetText(L["Repair with guild money"])
	guildCheck:SetChecked(GoodOptions.guildRepair or GoodOptions.guildOnlyRaid)

	-- The dropdown’s here, brother! And it’s droppin’ choices harder than a powerbomb on raid night!
	local guildRepairDropdown = CreateFrame("Frame", addon.."GuildRepairDropdown", OP, "UIDropDownMenuTemplate")
	guildRepairDropdown:SetPoint("TOPLEFT", guildCheck, "BOTTOMLEFT", -15, 0)
	UIDropDownMenu_SetWidth(guildRepairDropdown, 180)

	-- Options so smooth, they butter their own toast. Let’s gooo!
	local function addOption(dropdown, text, value, index, func, checked, extra, sVars)
		local info = UIDropDownMenu_CreateInfo()
		info.text = text
		info.value = value
		info.checked = checked
		info.func = function()
			if sVars then
				for k, v in pairs(sVars) do GoodOptions[k] = v end
			end
			UIDropDownMenu_SetText(dropdown, text)
			UIDropDownMenu_SetSelectedID(dropdown, index)
			func()
		end
		if extra then
			for k, v in pairs(extra) do info[k] = v end
		end
		UIDropDownMenu_AddButton(info)
	end

	-- Stay classy, guild dropdown!
	local function updateGuildDropdown()
		local value = ({always = 1, raid = 2})[GoodOptions.guildMode]
		UIDropDownMenu_SetSelectedID(guildRepairDropdown, value)
		UIDropDownMenu_SetText(guildRepairDropdown, value == 1 and L["All the time"] or L["Only in a raid group"])
	end

	-- Behold! The ancient scrolls of guild repair logic, etched in the fires of convenience!
	local guildStates = {
		always = {guildRepair = true, guildOnlyRaid = false, mode = "always"},
		raid   = {guildRepair = false, guildOnlyRaid = true,  mode = "raid"},
	}

	-- Let the checkbox think it's in charge!
	local function updateGuildState()
		local enabled = guildCheck:GetChecked()
		local newState
		if enabled then
			newState = guildStates[GoodOptions.guildMode] or guildStates.always
			UIDropDownMenu_EnableDropDown(guildRepairDropdown)
		else
			newState = { guildRepair = false, guildOnlyRaid = false, mode = GoodOptions.guildMode }
			UIDropDownMenu_DisableDropDown(guildRepairDropdown)
		end
		GoodOptions.guildRepair = newState.guildRepair
		GoodOptions.guildOnlyRaid = newState.guildOnlyRaid
		GoodOptions.guildMode = newState.mode
		updateGuildDropdown()
	end
	guildCheck:SetScript("OnClick", updateGuildState)

	-- For when you wanna take control!
	local modCheck = CreateFrame("CheckButton", addon.."ModCheck", OP, "InterfaceOptionsCheckButtonTemplate")
	modCheck:SetPoint("TOPLEFT", guildRepairDropdown, "BOTTOMLEFT", 15, -10)
	_G[modCheck:GetName() .. "Text"]:SetText(L["Hold Modifier Key to prevent repairing"])
	modCheck:SetChecked(GoodOptions.useModKey)
	modCheck:SetScript("OnClick", function(self)
		GoodOptions.useModKey = self:GetChecked()
	end)

	-- Talk to me, baby! or not...
	local msgCheck = CreateFrame("CheckButton", addon.."MessageCheck", OP, "InterfaceOptionsCheckButtonTemplate")
	msgCheck:SetPoint("TOPLEFT", modCheck, "BOTTOMLEFT", 0, -15)
	_G[msgCheck:GetName() .. "Text"]:SetText(L["Show messages in chat"])
	msgCheck:SetChecked(GoodOptions.printMessage)
	msgCheck:SetScript("OnClick", function(self)
		GoodOptions.printMessage = self:GetChecked()
	end)

	-- Style points incoming!
	local currencyLabel = OP:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	currencyLabel:SetPoint("TOPLEFT", msgCheck, "BOTTOMLEFT", 0, -20)
	currencyLabel:SetText(L["Currency display style:"])

	-- A little preview? Oh, you fancy huh?!
	local exampleText = OP:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	exampleText:SetPoint("LEFT", currencyLabel, "RIGHT", 5, 0)
	exampleText:SetTextColor(1, 1, 1)
	
	-- Give 'em a taste of the goods!
	local function updateExample()
		local money = ns.formatMoney(123456)
		if money then
			exampleText:SetText(money)
		else
			exampleText:SetText("|cffff0000" .. L["Error formatting money!"] .. "|r")
		end
	end

	-- Time to let the people choose.
	local currencyDropdown = CreateFrame("Frame", addon.."currencyDropdown", OP, "UIDropDownMenuTemplate")
	currencyDropdown:SetPoint("TOPLEFT", currencyLabel, "BOTTOMLEFT", -15, -15)
	UIDropDownMenu_SetWidth(currencyDropdown, 180)

	-- Bold AND beautiful!
	local colorCheck = CreateFrame("CheckButton", addon.."ColorCheck", OP, "InterfaceOptionsCheckButtonTemplate")
	colorCheck:SetPoint("TOPLEFT", currencyDropdown, "BOTTOMLEFT", 15, 0)
	local colorCheckText = _G[colorCheck:GetName() .. "Text"]
	colorCheckText:SetText(L["Use color formatting"])
	colorCheck:SetChecked(GoodOptions.useColor)
	colorCheck:SetScript("OnClick", function(self)
		GoodOptions.useColor = self:GetChecked()
		updateExample()
	end)

	-- You either see it... or you *really* see it!
	local function updateColorState()
		if GoodOptions.currencyStyle == "coin" then
			colorCheck:Disable()
			colorCheckText:SetTextColor(0.5, 0.5, 0.5)
		else
			colorCheck:Enable()
			colorCheckText:SetTextColor(1, 1, 1)
		end
		updateExample()
	end

	-- Step right up, pick your flavor of bling!
	UIDropDownMenu_Initialize(currencyDropdown, function()
		addOption(currencyDropdown, L["Short text"], "short", 1, updateColorState, (GoodOptions.currencyStyle == "short"), nil, {
			currencyStyle = "short"
		})
		addOption(currencyDropdown, L["Full text"], "full", 2, updateColorState, (GoodOptions.currencyStyle == "full"), nil, {
			currencyStyle = "full"
		})
		addOption(currencyDropdown, L["Coin icons"], "coin", 3, updateColorState, (GoodOptions.currencyStyle == "coin"), {
			tooltipTitle = L["Display Warning"],
			tooltipText = L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."],
			tooltipOnButton = true
		}, {
			currencyStyle = "coin"
		})
		local styleID = ({short = 1, full = 2, coin = 3})[GoodOptions.currencyStyle] or 1
		UIDropDownMenu_SetSelectedID(currencyDropdown, styleID)
		UIDropDownMenu_SetText(currencyDropdown, styleID == 1 and L["Short text"] or styleID == 2 and L["Full text"] or L["Coin icons"])
		updateExample()
	end)
	UIDropDownMenu_JustifyText(currencyDropdown, "LEFT")

	-- Wide enough for dreams, not too wide for chaos!
	UIDropDownMenu_Initialize(guildRepairDropdown, function()
		addOption(guildRepairDropdown, L["All the time"], "always", 1, updateGuildDropdown, (GoodOptions.guildMode == "always"), nil, {
			guildRepair = true,
			guildOnlyRaid = false,
			guildMode = "always"
		})
		addOption(guildRepairDropdown, L["Only in a raid group"], "raid", 2, updateGuildDropdown, (GoodOptions.guildMode == "raid"), nil, {
			guildRepair = false,
			guildOnlyRaid = true,
			guildMode = "raid"
		})
	end)
	UIDropDownMenu_JustifyText(guildRepairDropdown, "LEFT")

	-- Get everything lookin' tight before showtime!
	updateColorState()
	updateGuildState()
end)

-- And now... the main event!
InterfaceOptions_AddCategory(OP)
