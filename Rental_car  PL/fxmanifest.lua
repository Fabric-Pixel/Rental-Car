fx_version 'cerulean'
game 'gta5'

author 'Pixel'
description 'Skrypt na wypożyczanie aut.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@idev_keys/shared.lua',
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

dependencies {
    'ox_lib', 
    'ox_inventory', 
    'ox_target', 
    'idev_keys'
}

lua54 'yes' 
