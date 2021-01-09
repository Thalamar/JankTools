local AddonName, TTools = ...

local module = TTools.UI:NewModule("MPlus", "Mythic Plus")
local testmod = TTools.UI:NewModule("GuildKeys", "Guild Keys")
local testmod2 = TTools.UI:NewModule("JankStuff", "Jank Stuff")

module.title = module:CreateFontString(nil, 'ARTWORK', 'InterUIBold_Normal')
module.title:SetPoint('TOPLEFT', module, 'TOPLEFT')
module.title:SetText("Mythic Plus Key Information - Week")


