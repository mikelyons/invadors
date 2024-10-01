--[[
  zenquotes.lua

  based on gravatar.lua

  https://zenquotes.io/api/[mode]/[key]?option1=value&option2=value
  https://zenquotes.io/api/quotes
]]


-- local socket = require "socket"
local http = require "socket.http"
local md5 = require 'lib/md5'

local Zenquotes = {}

function Zenquotes:new()
end


function Zenquotes:load()
  self.quotes = http.request('http://www.gravatar.com/avatar/'..hashedEmail) -- 'https://zenquotes.io/api/[mode]/[key]?option1=value&option2=value'
  -- print('-=-=-=-=-=-=-=-=-=-=-=-=-')
  -- print(raintar)
  if self.quotes ~= nil then
    self.quotes = love.filesystem.newFileData(self.raintar, "raintar.png")
    self.quotes = love.graphics.newImage(self.raintar)
  else -- Default avatar == no internet or gravatar down
    self.quotes = love.graphics.newImage("assets/newer/brian.png")
  end
end