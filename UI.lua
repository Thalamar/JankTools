local AddonName, TTools = ...

local optionsFrameName = "tModule"
local thalaUI = CreateFrame('FRAME', 'ThalaUI', UIParent)

thalaUI.width = 700
thalaUI.height = 500
thalaUI.listWidth = 100
thalaUI.listItemHeight = 24
thalaUI.modules = {}

thalaUI:SetFrameStrata('DIALOG')
thalaUI:SetSize(thalaUI.Width, thalaUI.Height)
thalaUI:SetPoint('CENTER', UIParent, 'CENTER')
thalaUI:EnableMouse(true)
thalaUI:SetClampedToScreen(true)
thalaUI:Hide()
TTools.UI = thalaUI

local tMenu = CreateFrame('FRAME', '$menuBar', thalaUI)
tMenu:SetSize(thalaUI.ListWidth, thalaUI.Height)
tMenu:SetPoint('TOPLEFT', thalaUI, 'TOPLEFT')
tMenu.texture = tMenu:CreateTexture(nil, 'BACKGROUND')
tMenu.texture:SetAllPoints(tMenu)
tMenu.texture:SetColorTexture(33/255, 33/255, 33/255, 0.8)

function TTools.UI:NewModule(modName)
    if thalaUI.modules[modName] then
        return false
    end
    local self = {}

    --- CREATE MAIN PANEL
    self.id = #thalaUI.modules + 1
    self.name = modName
    self.frame = CreateFrame("Frame",optionsFrameName..modName,thalaUI)
    self:SetSize(thalaUI.Width-thalaUI.ListWidth,Options.Height-16)
    self:SetPoint("TOPLEFT",thalaUI.ListWidth,-16)

    --- CREATE MENU LIST ITEM
    local menuItem = CreateFrame('FRAME', listFrameName..modName, tMenu)
    local menuItemText = menuItem:CreateFontString(nil,"ARTWORK",template):SetJustifyH("LEFT")
    menuItemText:SetText(modName)
    menuItem:SetSize(thalaUI.ListWidth, thalaUI.listItemHeight)
    menuItem:SetPoint('TOPLEFT', tMenu, (self.id-1)*thalaUI.ListItemHeight*-1)
    menuItem:SetScript("OnClick", function() thalaUI:SetModule(self) end)
    menuItem.pos = self.id

    thalaUI.modules[modName] = self

    self:Hide()
    return self
end

--- CHANGE MODULE
function thalaUI:SetModule(mod)
    if thalaUI.currentModule then
        thalaUI.currentModule.frame:Hide()
    end
    thalaUI.currentModule = mod
    thalaUI.currentModule.frame:Show()
end
