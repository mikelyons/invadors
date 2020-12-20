local socket = require "socket"
local http = require "socket.http"
local md5 = require 'lib/md5'

local Gravatar = {}

  -- https://eng.libretexts.org/Courses/Delta_College/Introduction_to_Programming_Concepts_-_Python/12%3A_Networked_Programs/12.03%3A_Retrieving_an_image_over_HTTP
  -- https://love2d.org/forums/viewtopic.php?t=82150
  -- @TODO - make this an avatar componentized

function Gravatar:new(x,y)
  local gravatar = {}
  local x = x
  local y = y
  local hashedEmail = md5.sumhexa('lyons.mr@gmail.com')

  function gravatar:load()
    self.raintar = http.request('http://www.gravatar.com/avatar/'..hashedEmail)
    self.raintar = love.filesystem.newFileData(self.raintar, "raintar.png")
    self.raintar = love.graphics.newImage(self.raintar)
  end

  function gravatar:draw()
    love.graphics.setColor(900, 90, 90, 255)
    love.graphics.draw(self.raintar, x + 500, y)
  end

  return gravatar
end

return Gravatar