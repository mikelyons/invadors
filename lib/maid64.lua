--[[
  maid64.lua

  low resolution scaler
  forum: https://love2d.org/forums/viewtopic.php?t=82034

  this is a modified version from the above thread.
  The original is here: https://github.com/adekto/maid64

  @TODO update to github version above (this is v 1.0, gh is 1.6)
]]
maid64 = {}--I declare maid64 up here. Its a global anyway so this is better practice than in in a function
function maid64.setup(pixels)-- maid64 is now maid64.setup
    maid64.size = pixels or 64
    maid64.scaler = love.graphics.getHeight() / maid64.size
    maid64.x = love.graphics.getWidth()/2-(maid64.scaler*(maid64.size/2))
    maid64.y = love.graphics.getHeight()/2-(maid64.scaler*(maid64.size/2))
    maid64.canvas = love.graphics.newCanvas(maid64.size, maid64.size)
    maid64.canvas:setFilter("nearest","nearest")
end

maid64.start = function ()--part of maid64_draw is now maid64.start
   	love.graphics.setCanvas(maid64.canvas)
   	love.graphics.clear()
    end
maid64.finish = function () --The other half of maid64_draw is now maid64.finish
    	love.graphics.setCanvas()
    	love.graphics.draw(maid64.canvas, maid64.x,maid64.y,0,maid64.scaler,maid64.scaler)
end

function maid64.resize(w, h)-- this is a function for neatnesses sake
    if h < w then
        maid64.scaler = h / maid64.size
    else
        maid64.scaler = w / maid64.size
    end
    maid64.x = w/2-(maid64.scaler*(maid64.size/2))
    maid64.y = h/2-(maid64.scaler*(maid64.size/2))
end

