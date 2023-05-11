--[[
  button.lua

  a button module for creating configurable buttons in the ui
]]

print('button.lua ->')

Button = Class('Button')

function Button:initialize(
  x,y,
  w,h,
  text,
  func
)
  self.pos = {
    x = x or 0,
    y = y or 0
  }
  self.size = {
    w = w or 100,
    h = h or 50}
  self.margin = 10
  self.padding = 10
  self.text = text or 'default button'
  self.func = func or function() print('default button func') end
  self.now = false
  self.last = false
end

function Button:update() end

function Button:draw()
  love.graphics.setColor(55, 255, 55, 255)
  love.graphics.rectangle(
    'fill',
    self.pos.x,
    self.pos.y,
    self.size.w,
    self.size.h
  )
  love.graphics.setColor(5, 5, 55, 255)
  love.graphics.print(
    self.text,
    self.pos.x, self.pos.y --,
    -- r -- r,
    -- sx,
    -- sy,
    -- ox,
    -- oy
  )
end

