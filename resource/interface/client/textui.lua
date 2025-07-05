<<<<<<< HEAD
---@class TextUIOptions
---@field position? 'right-center' | 'left-center' | 'top-center';
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---@class TextUIOptions
---@field position? 'right-center' | 'left-center' | 'top-center' | 'bottom-center';
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@field icon? string | {[1]: IconProp, [2]: string};
---@field iconColor? string;
---@field style? string | table;
---@field alignIcon? 'top' | 'center';

local isOpen = false
local currentText

---@param text string
---@param options? TextUIOptions
function lib.showTextUI(text, options)
    if currentText == text then return end

    if not options then options = {} end

    options.text = text
    currentText = text

    SendNUIMessage({
        action = 'textUi',
        data = options
    })

    isOpen = true
end

function lib.hideTextUI()
    SendNUIMessage({
        action = 'textUiHide'
    })

    isOpen = false
    currentText = nil
end

---@return boolean, string | nil
function lib.isTextUIOpen()
    return isOpen, currentText
<<<<<<< HEAD
end
=======
end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
