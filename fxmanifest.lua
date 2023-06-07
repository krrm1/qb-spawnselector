fx_version 'bodacious'
games { 'rdr3', 'gta5' }
version '2.1.0'

client_script { 
   'client.lua',
   'Config.lua'
} 

ui_page('interface/interface.html')

files {
   'interface/interface.html',
   'interface/*',
} 

