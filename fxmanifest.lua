fx_version 'cerulean'
game 'gta5'
author 'SovietRulez#0001'
description 'Money wash For QBCore'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/main.lua',
	'config.lua'
}

server_script 'server/main.lua'

