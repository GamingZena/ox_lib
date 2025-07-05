<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@alias WeaponResourceFlags
---| 1 WRF_REQUEST_BASE_ANIMS
---| 2 WRF_REQUEST_COVER_ANIMS
---| 4 WRF_REQUEST_MELEE_ANIMS
---| 8 WRF_REQUEST_MOTION_ANIMS
---| 16 WRF_REQUEST_STEALTH_ANIMS
---| 32 WRF_REQUEST_ALL_MOVEMENT_VARIATION_ANIMS
---| 31 WRF_REQUEST_ALL_ANIMS

---@alias ExtraWeaponComponentFlags
---| 0 WEAPON_COMPONENT_NONE
---| 1 WEAPON_COMPONENT_FLASH
---| 2 WEAPON_COMPONENT_SCOPE
---| 4 WEAPON_COMPONENT_SUPP
---| 8 WEAPON_COMPONENT_SCLIP2
---| 16 WEAPON_COMPONENT_GRIP

---Load a weapon asset. When called from a thread, it will yield until it has loaded.
---@param weaponType string | number
<<<<<<< HEAD
---@param timeout number? Number of ticks to wait for the asset to load. Default is 500.
---@param weaponResourceFlags WeaponResourceFlags? Default is 31.
---@param extraWeaponComponentFlags ExtraWeaponComponentFlags? Default is 0.
---@return string | number? weaponType
=======
---@param timeout number? Approximate milliseconds to wait for the asset to load. Default is 10000.
---@param weaponResourceFlags WeaponResourceFlags? Default is 31.
---@param extraWeaponComponentFlags ExtraWeaponComponentFlags? Default is 0.
---@return string | number weaponType
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function lib.requestWeaponAsset(weaponType, timeout, weaponResourceFlags, extraWeaponComponentFlags)
    if HasWeaponAssetLoaded(weaponType) then return weaponType end

    local weaponTypeType = type(weaponType) --kekw

    if weaponTypeType ~= 'string' and weaponTypeType ~= 'number' then
        error(("expected weaponType to have type 'string' or 'number' (received %s)"):format(weaponTypeType))
    end

    if weaponResourceFlags and type(weaponResourceFlags) ~= 'number' then
        error(("expected weaponResourceFlags to have type 'number' (received %s)"):format(type(weaponResourceFlags)))
    end

    if extraWeaponComponentFlags and type(extraWeaponComponentFlags) ~= 'number' then
        error(("expected extraWeaponComponentFlags to have type 'number' (received %s)"):format(type(extraWeaponComponentFlags)))
    end

<<<<<<< HEAD
    RequestWeaponAsset(weaponType, weaponResourceFlags or 31, extraWeaponComponentFlags or 0)

    if not coroutine.isyieldable() then return weaponType end

    return lib.waitFor(function()
        if HasWeaponAssetLoaded(weaponType) then return weaponType end
    end, ("failed to load weaponType '%s'"):format(weaponType), timeout or 500)
=======
    return lib.streamingRequest(RequestWeaponAsset, HasWeaponAssetLoaded, 'weaponHash', weaponType, timeout, weaponResourceFlags or 31, extraWeaponComponentFlags or 0)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.requestWeaponAsset
