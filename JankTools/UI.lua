local AddonName, TTools = ...

local optionsFrameName = "tModule"
local listFrameName = "tMod"
local thalaUI = CreateFrame('FRAME', 'ThalaUI', UIParent)

thalaUI.width = 700
thalaUI.height = 500
thalaUI.listWidth = 150
thalaUI.listItemHeight = 40
thalaUI.modules = {}

thalaUI:SetFrameStrata('DIALOG')
thalaUI:SetSize(thalaUI.width, thalaUI.height)
thalaUI:SetPoint('CENTER', UIParent, 'CENTER')
thalaUI:EnableMouse(true)
thalaUI:SetMovable(true)
thalaUI:SetClampedToScreen(true)
thalaUI.texture = thalaUI:CreateTexture(nil, 'BACKGROUND')
thalaUI.texture:SetAllPoints(thalaUI)
thalaUI.texture:SetColorTexture(33/255, 33/255, 33/255, 0.9)
thalaUI.title = thalaUI:CreateFontString(nil, "ARTWORK", "InterUIBold_Large")
thalaUI.title:SetText("Jank Tools v0.0.1")
thalaUI.title:SetPoint('TOPLEFT', thalaUI, 'TOPLEFT', thalaUI.listWidth+30, -10)
thalaUI:Hide()
TTools.UI = thalaUI

local tMenu = CreateFrame('FRAME', '$menuBar', thalaUI)
tMenu:SetSize(thalaUI.listWidth, thalaUI.height)
tMenu:SetPoint('TOPLEFT', thalaUI, 'TOPLEFT')
tMenu.texture = tMenu:CreateTexture(nil, 'BACKGROUND')
tMenu.texture:SetAllPoints(tMenu)
tMenu.texture:SetColorTexture(33/255, 33/255, 33/255, 0.9)

local divider = tMenu:CreateTexture(nil, 'BACKGROUND')
divider:SetSize(2, thalaUI.height)
divider:SetColorTexture(.6, .6, .6, .8)
divider:SetPoint('TOPLEFT', tMenu, 'TOPRIGHT', 0, 0)

local closeButton = CreateFrame('BUTTON', 'btnClose', thalaUI)
closeButton:SetNormalTexture('Interface\\AddOns\\JankTools\\Media\\Texture\\close')
closeButton:SetSize(12, 12)
closeButton:GetNormalTexture():SetVertexColor(.8, .8, .8, 0.8)
closeButton:SetScript('OnClick', function()
    thalaUI:Hide()
end)
closeButton:SetPoint('TOPRIGHT', thalaUI, 'TOPRIGHT', -14, -14)
closeButton:SetScript('OnEnter', function(self)
    self:GetNormalTexture():SetVertexColor(126/255, 126/255, 126/255, 0.8)
end)
closeButton:SetScript('OnLeave' , function(self)
    self:GetNormalTexture():SetVertexColor(0.8, 0.8, 0.8, 0.8)
end)

function TTools.UI:NewModule(modName, listName)
    if thalaUI.modules[modName] then
        return false
    end
    local x = {}

    --- CREATE MAIN PANEL
    x = CreateFrame("Frame",optionsFrameName..modName, thalaUI)
    x.name = modName
    x.id = #thalaUI.modules + 1
    x:SetSize((thalaUI.width-thalaUI.listWidth)-15, thalaUI.height-30)
    x:SetPoint('TOPRIGHT',thalaUI,'TOPRIGHT', 0, -30)
    x.texture = x:CreateTexture(nil, 'BACKGROUND')
    x.texture:SetAllPoints(x)
    x.texture:SetColorTexture(33/255, 33/255, 33/255, 1)

    x.title = x:CreateFontString(nil, "ARTWORK")
    x.title:SetFont("Font\\Inter-UI-Regular.ttf", 13, "OUTLINE")
    x.title:SetPoint('TOPLEFT', x, 'TOPLEFT', 0, -16)
    x.title:SetText("|cPaladinHello World!")
    print("Module count: "..#thalaUI.modules)
    print("Module ID: "..x.id)
    --- CREATE MENU LIST ITEMq
    local menuItem = CreateFrame('BUTTON', listFrameName..modName, tMenu)
    local menuItemText = menuItem:CreateFontString(nil,"ARTWORK", "InterUIBold_Normal")
    menuItemText:SetText(listName)
    menuItemText:SetPoint('CENTER', menuItem, 'CENTER')
    print(modName)
    menuItem:SetSize(thalaUI.listWidth, thalaUI.listItemHeight)
    menuItem:SetPoint('TOPLEFT', tMenu, 'TOPLEFT', 0, (x.id-1)*thalaUI.listItemHeight*-1)
    menuItem:SetScript("OnClick", function(self) thalaUI:SetModule(x) end)
    menuItem.pos = x.id

    thalaUI.modules[x.id] = x

    x:Hide()
    return x
end

--- CHANGE MODULE
function thalaUI:SetModule(mod)
    if thalaUI.currentModule then
        thalaUI.currentModule:Hide()
    end
    thalaUI.currentModule = mod
    thalaUI.currentModule:Show()
end
