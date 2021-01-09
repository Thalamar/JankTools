local AddonName, TTools = ...
local AddonPrefix = "TTOOLSADDON"
TTools.version = "0.0.1"
TTools.MsgPrefix = {
    [AddonPrefix] = true
}
TTools.addonMsgEvents = {}


TTools.Locale = GetLocale()
TTools.ClientVersion = select(4, GetBuildInfo())
TTools.Modules = {}
TTools.ModulesOptions = {}

--- GET CHARACTER INFORMATION
TTools.User = {}
TTools.User.Character = UnitName('player')
TTools.User.Realm = GetRealmName()
TTools.User.Level = UnitLevel('player')
TTools.User.Class = UnitClass('player')

local SendAddonMsg = C_ChatInfo.SendAddonMessage

SlashCmdList["TTOOLS"] = function(p)
    local args = strlower(p)

    if (args == "test") then

    elseif (args == "test2") then

    end

    TTools.UI:Show()
end

SLASH_TTOOLS1 = "/ttools"
SLASH_TTOOLS2 = "/thalatools"

--- Main Frame for background tasks
TTools.frame = CreateFrame('FRAME')
TTools.frame:SetScript("OnEvent", function(self, event)
    if (event == "CHAT_MSG_ADDON") then
        ---Parse message received from Addon

    elseif (event == "ADDON_LOADED") then
        ---Addon successfully loaded

    end
end)



function TTools.Modules:New(moduleName, listName)
    if TTools.Modules[moduleName] then
        return false
    end
    local self = {}
    setmetatable(self, TTools.Module)

    self.frame = CreateFrame("Frame", nil)
    self.frame:SetScript("OnEvent",TTools.Module.Event)
    self.frame.events = {}
    self.name = moduleName

    self.options = TTools.UI:NewModule(moduleName, listName)
    self.options.moduleName = moduleName

    table.insert(TTools.Modules,self)

    print("New Thalatools module: "..moduleName)

    return self
end

function TTools.Modules:Event(event,...)
    self[event](self,...)
end


function TTools.SendMsg(prefix, msg, tochat, touser, addonPrefix)
    addonPrefix = addonPrefix or AddonPrefix
    msg = msg or ""
    if tochat and not touser then
        SendAddonMsg(addonPrefix, prefix .. "\t" .. msg, tochat)
    elseif tochat and touser then
        SendAddonMsg(addonPrefix, prefix .. "\t" .. msg, tochat,touser)
    else
        local chat_type, playerName = ExRT.F.chatType()
        if chat_type == "WHISPER" and playerName == ExRT.SDB.charName then
            TTools.GetExMsg(ExRT.SDB.charName, prefix, strsplit("\t", msg))
            return
        end
        SendAddonMsg(addonPrefix, prefix .. "\t" .. msg, chat_type, playerName)
    end
end

function TTools.GetMsg(sender, prefix, ...)
    for _,mod in pairs(TTools.addonMsgEvents) do
        mod:AddonMessage(sender, prefix, ...)
    end
end

TTools.frame:RegisterEvent("CHAT_MSG_ADDON")
TTools.frame:RegisterEvent("ADDON_LOADED")