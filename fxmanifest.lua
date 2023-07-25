

shared_script '@FiveEye/FiveEye.lua'






fx_version 'cerulean'
game 'gta5'

author "almez#9087"

ui_page 'html/index.html'

client_scripts {
  'client.lua',
  'config.lua'
}

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

files {
  'html/main.js',
  'html/style.css',
  'html/index.html',
  "html/images/*.png",
  'html/dist/*.*',
}


