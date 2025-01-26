fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'krrm1'
description 'Allows players to select a spawn point from a list of available locations'
version '2.2.0'

client_script { 
   'client.lua',
   'Config.lua'
} 

ui_page 'interface/interface.html'

files {
   'interface/interface.html',
   'interface/*',
} 

