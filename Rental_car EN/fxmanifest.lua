fx_version 'cerulean'
game 'gta5'

author 'Pixel'
description 'Car rental script.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
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
}

lua54 'yes' 
