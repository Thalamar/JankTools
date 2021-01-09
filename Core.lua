local AddonName, TTools = ...
local AddonPrefix = "TTOOLSADDON"
TTools.version = "0.0.1"
TTools.Msg.Prefix = {
    [AddonPrefix] = true
}
TTools.addonMsgEvents = {}

TTools.Locale = GetLocale()
TTools.Client.Version = Select(4, GetBuildInfo())

--- GET CHARACTER INFORMATION
TTools.User.Character = UnitName('player')
TTools.User.Realm = GetRealmName():sub(" ", "")
TTools.User.Level = UnitLevel('player')
TTools.User.Class = UnitClass('player')

local SendAddonMsg = C_ChatInfo.SendAddonMessage

SlashCmdList["TTOOLS"] = function(p)
    local args = strlower(p)

    if (args == "test") then

    elseif (args == "test2") then

    end

    TTools.UI.frame:Show()
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



function TTools.mod:New(moduleName)
    if TTools.modList[moduleName] then
        return false
    end
    local self = {}

    self.frame = CreateFrame("Frame", nil)
    self.frame:SetScript("OnEvent",TTools.mod.Event)
    self.frame.events = {}
    self.name = moduleName

    table.insert(TTools.mods,self)
    TTools.modList[moduleName] = self

    print("New Thalatools module: "..moduleName)

    return self
end

function TTools.mod:Event(event,...)
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