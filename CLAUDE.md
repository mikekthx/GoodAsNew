# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Good As New is a World of Warcraft addon that auto-sells gray-quality junk and auto-repairs gear at vendors, optionally spending guild bank funds. **`main` targets World of Warcraft: Forever** (Interface version 16001 — internally codenamed "Camelot" in Blizzard's own source tree), which runs on the modern client engine despite serving vanilla-era content. The prior WotLK/Project Epoch (3.3.5a) version is preserved on the **`3.3.5a` branch** and is no longer developed on `main`. There is no build system, package manager, or test suite — it's plain Lua executed directly by the WoW client's embedded Lua interpreter.

## Development workflow

There are no build/lint/test commands. To develop:
1. Edit the `.lua` files directly.
2. Symlink or copy the repo into the WoW client's `Interface/AddOns/GoodAsNew` folder.
3. Reload the addon in-game with `/reload` (or restart the client) to pick up changes.
4. Verify manually in-game: open a vendor window and confirm junk sells and repair fires as expected, testing both personal-gold and guild-bank repair paths, plus the options panel (ESC > Options > AddOns > Good As New).

Since there's no automated test harness, treat manual in-game verification at a merchant as the equivalent of running tests before considering a change done.

A reference source dump of Blizzard's client/FrameXML code (including the Forever/"Camelot" product) is available locally at `C:\Users\Mike\source\repos\wow-ui-source` — check it before assuming an API's signature or namespace when touching game-facing code, rather than relying on memory of older WoW API versions.

## Load order and architecture

[GoodAsNew.toc](GoodAsNew.toc) defines the fixed load order, and each file depends on state set up by the ones before it:

1. **[locale.lua](locale.lua)** — Builds the `ns.L` localization table keyed off `GetLocale()`. Falls through a chain of `if lang == "..."` blocks (enUS/enGB, deDE, frFR, esES/esMX, ruRU, koKR, zhCN, zhTW), each populating the same fixed set of string keys plus `L.g`/`L.s`/`L.c` (gold/silver/copper unit labels as `{short, full}` pairs). `L`'s metatable `__index` returns the raw key as a fallback so a missing translation degrades to the English string rather than erroring. All user-facing strings must be added to *every* language block to stay in sync. `GetLocale()` and its locale codes are unchanged from older WoW clients, so this file needed no porting.
2. **[config.lua](config.lua)** — Initializes `GoodOptions` (the addon's `SavedVariables`, declared in the .toc) from a `defaults` table, merging in any keys missing from a saved profile. Defines `ns.formatMoney`/`ns.GetCoinText` (shared money-formatting used by both the options panel preview logic and core.lua's chat output). Registers the options panel using the modern `Settings` API (`Settings.RegisterVerticalLayoutCategory` + `Settings.RegisterAddOnSetting` + `Settings.CreateCheckbox`/`Settings.CreateDropdown`, finished with `Settings.RegisterAddOnCategory`) — the legacy `InterfaceOptions_AddCategory`/`CreateFrame`+`UIDropDownMenuTemplate` panel style no longer exists on this client and must not be reintroduced. Each setting binds directly to a `GoodOptions` field via `RegisterAddOnSetting`'s `variableTbl`/`variableKey` args, so the UI writes straight to saved variables with no separate "apply" step.
3. **[core.lua](core.lua)** — The actual behavior, driven by the `MERCHANT_SHOW` event (plus an immediate check if the merchant frame is already open). On trigger it iterates all bags (`0` to `NUM_BAG_SLOTS`) via the `C_Container` namespace (`C_Container.GetContainerItemID`/`GetContainerNumSlots`/`UseContainerItem` — bag/slot arguments unchanged from older globals, just namespaced), sells any item with quality `0` (gray/poor) and a nonzero vendor price (item id `6196`, Noboru's Cudgel, is hardcoded as exempt), then evaluates repair. Repair-related calls (`CanMerchantRepair`, `GetRepairAllCost`, `CanGuildBankRepair`, `GetGuildBankWithdrawMoney`, `RepairAllItems`) remain plain globals, unchanged from the legacy API. `IsInRaid()` replaces the old `GetNumRaidMembers() ~= 0` check. Item lookups go through `C_Item.GetItemInfo` (moved out of the global namespace; same positional return values as the old global `GetItemInfo`).

Cross-cutting conventions:
- Every file opens with `local _, ns = ...` to pull the addon's shared table from the varargs WoW passes to addon chunks; `ns` is the mechanism for sharing functions/state between the three files (`ns.L`, `ns.formatMoney`, `ns.GetCoinText`).
- Frequently-used WoW API functions are localized at the top of a file (e.g. `local GetContainerItemID = C_Container.GetContainerItemID`) as a performance convention — follow this pattern for calls made in a hot path like `itsShowtime`'s bag loop. Calls made once per merchant visit (repair-related globals, `IsInRaid`) are not localized, matching the existing pattern.
- `itsShowtime` in core.lua caches `GetItemInfo` quality/price lookups per item id across invocations (`itemCacheQuality`/`itemCachePrice`, reused via `wipe` rather than reallocated) since item lookups can be relatively expensive and items reappear across bag scans.
- User-facing text always goes through `L["..."]` for localization and `ns.formatMoney(cost)` for currency — never format copper amounts or print raw English strings directly.
- `GoodOptions.guildMode` is a single tri-state field (`"off"` / `"always"` / `"raid"`) driving guild-bank repair — this replaced the old two-boolean (`guildRepair`/`guildOnlyRaid`) + dropdown combo, which only existed to work around the legacy options widget model. Don't reintroduce the boolean pair.

## Localization

To add or fix a translation, edit [locale.lua](locale.lua) directly — pick the matching `if lang == "..."` block and update the string table there. New user-facing strings need a corresponding `L["key"]` entry added to *every* language block (not just enUS) to avoid falling back to raw English/keys for other locales.
