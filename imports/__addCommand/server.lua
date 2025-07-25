-- DO NOT USE! Old syntax for addCommand (prior to v3.0)
---@todo convert input and call standard function?

<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
local commands = {}

SetTimeout(1000, function()
    TriggerClientEvent('chat:addSuggestions', -1, commands)
end)

<<<<<<< HEAD
AddEventHandler('playerJoining', function(source)
=======
AddEventHandler('playerJoining', function()
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    TriggerClientEvent('chat:addSuggestions', source, commands)
end)

local function chatSuggestion(name, parameters, help)
    local params = {}

    if parameters then
        for i = 1, #parameters do
            local arg, argType = string.strsplit(':', parameters[i])

            if argType and argType:sub(0, 1) == '?' then
                argType = argType:sub(2, #argType)
            end

            params[i] = {
                name = arg,
                help = argType
            }
        end
    end

    commands[#commands + 1] = {
        name = '/' .. name,
        help = help,
        params = params
    }
end

---@deprecated
---@param group string | string[] | false
---@param name string | string[]
---@param callback function
---@param parameters table
function lib.__addCommand(group, name, callback, parameters, help)
    if not group then group = 'builtin.everyone' end

    if type(name) == 'table' then
        for i = 1, #name do
            ---@diagnostic disable-next-line: deprecated
            lib.__addCommand(group, name[i], callback, parameters, help)
        end
    else
        chatSuggestion(name, parameters, help)

        RegisterCommand(name, function(source, args, raw)
            source = tonumber(source) --[[@as number]]

            if parameters then
                for i = 1, #parameters do
                    local arg, argType = string.strsplit(':', parameters[i])
                    local value = args[i]

                    if arg == 'target' and value == 'me' then value = source end

                    if argType then
                        local optional

                        if argType:sub(0, 1) == '?' then
                            argType = argType:sub(2, #argType)
                            optional = true
                        end

                        if argType == 'number' then
                            value = tonumber(value) or value
                        end

                        local type = type(value)

                        if type ~= argType and (not optional or type ~= 'nil') then
                            local invalid = ('^1%s expected <%s> for argument %s (%s), received %s^0'):format(name,
                                argType, i, arg, type)
                            if source < 1 then
                                return print(invalid)
                            else
                                return TriggerClientEvent('chat:addMessage', source, invalid)
                            end
                        end
                    end

                    args[arg] = value
                    args[i] = nil
                end
            end

            callback(source, args, raw)
        end, group and true)

        name = ('command.%s'):format(name)
        if type(group) == 'table' then
            for _, v in ipairs(group) do
                if not IsPrincipalAceAllowed(v, name) then lib.addAce(v, name) end
            end
        else
            if not IsPrincipalAceAllowed(group, name) then lib.addAce(group, name) end
        end
    end
end

---@diagnostic disable-next-line: deprecated
return lib.__addCommand
