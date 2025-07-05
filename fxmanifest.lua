<<<<<<< HEAD
--[[ FX Information ]] --
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

<<<<<<< HEAD
--[[ Resource Information ]] --
name 'ox_lib'
author 'Overextended'
version '3.14.0'
=======
name 'ox_lib'
author 'Overextended'
version '3.30.6'
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
license 'LGPL-3.0-or-later'
repository 'https://github.com/overextended/ox_lib'
description 'A library of shared functions to utilise in other resources.'

<<<<<<< HEAD
--[[ Manifest ]] --
dependencies {
    '/server:5848',
=======
dependencies {
    '/server:7290',
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    '/onesync',
}

ui_page 'web/build/index.html'

files {
    'init.lua',
<<<<<<< HEAD
=======
    'resource/settings.lua',
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    'imports/**/client.lua',
    'imports/**/shared.lua',
    'web/build/index.html',
    'web/build/**/*',
    'locales/*.json',
}

shared_script 'resource/init.lua'

shared_scripts {
    'resource/**/shared.lua',
    -- 'resource/**/shared/*.lua'
}

client_scripts {
    'resource/**/client.lua',
    'resource/**/client/*.lua'
}

server_scripts {
    'imports/callback/server.lua',
<<<<<<< HEAD
    'resource/**/server.lua',
    'resource/**/server/*.lua',
}

escrow_ignore {
    'imports/callback/server.lua',
    'resource/**/server.lua',
    'resource/**/server/*.lua',
    'resource/**/client.lua',
    'resource/**/client/*.lua',
    'resource/**/shared.lua',
    'resource/init.lua'
}
=======
    'imports/getFilesInDirectory/server.lua',
    'resource/**/server.lua',
    'resource/**/server/*.lua',
}
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
