-- local socket = require "socket"
local http = require "socket.http"
local md5 = require 'lib/md5'

local Gravatar = {}

  -- https://eng.libretexts.org/Courses/Delta_College/Introduction_to_Programming_Concepts_-_Python/12%3A_Networked_Programs/12.03%3A_Retrieving_an_image_over_HTTP
  -- https://love2d.org/forums/viewtopic.php?t=82150
  -- @TODO - make this an avatar componentized

function Gravatar:new(email, x,y)
  local gravatar = {}
  local x = x
  local y = y
  self.email = email
  -- TODO - get this from the user and store in the score file
  -- local hashedEmail = md5.sumhexa('lyons.mr@gmail.com')
  -- local hashedEmail = md5.sumhexa('thaonhi.nguyen411@gmail.com')
  -- local hashedEmail = md5.sumhexa('aaron.trostle@gmail.com')
  -- local hashedEmail = md5.sumhexa('test@example.com')
  -- local hashedEmail = md5.sumhexa('tsmckelvey@gmail.com.com')
  local hashedEmail = md5.sumhexa(score['email'])

  print(self.email)

  function gravatar:load()
    self.raintar = http.request('http://www.gravatar.com/avatar/'..hashedEmail)
    -- print('-=-=-=-=-=-=-=-=-=-=-=-=-')
    -- print(raintar)
    if self.raintar ~= nil then
      self.raintar = love.filesystem.newFileData(self.raintar, "raintar.png")
      self.raintar = love.graphics.newImage(self.raintar)
    else -- Default avatar == no internet or gravatar down
      self.raintar = love.graphics.newImage("assets/newer/brian.png")
    end
  end

  -- love.graphics.setColor(r, g, b, a)
  function gravatar:draw()
    local _r, _g, _b, _a = love.graphics.getColor()
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255), 255)
    love.graphics.draw(self.raintar, x + 500, y)
    love.graphics.print(score['email'], x + 500, y+85) -- default w,h 80x80
    love.graphics.setColor(_r, _g, _b, _a)
  end

  return gravatar
end

return Gravatar