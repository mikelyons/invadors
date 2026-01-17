--[[
  This is a basic example and can be modified to your needs.
The above code defines an ocean object with an update() and draw() function, and animation variables like frame, frames, currentTime and animationSpeed. The ocean.image variable is used to store the image of the ocean, the frameWidth and frameHeight are used to store the dimensions of the frames. The frame variable is used to store the current frame of the animation and the frames table contains the frames of the animation. The currentTime variable is used to store the time since the last frame change, and the animationSpeed variable is used to control the speed of the animation.

You can adjust the animation speed by adjusting the value of the animationSpeed variable, the lower the value the faster the animation runs. You can adjust the number of frames of the animation by adding or removing elements from the frames table, and you can adjust the size of the animation by adjusting the values passed to the draw() function.

Keep in mind that this is just a basic example and can be further modified and optimized to suit your needs, for example you can use a spritesheet to hold all the frames or you can use a library like anim8 that will make the animation process easier.
]]

local ocean = {}

-- Load the ocean image
ocean.image = love.graphics.newImage("ocean.png")

-- Create the animation variables
ocean.frameWidth = ocean.image:getWidth()
ocean.frameHeight = ocean.image:getHeight()
ocean.frame = 1
ocean.frames = {1, 2, 3, 4}
ocean.currentTime = 0
ocean.animationSpeed = 0.5

-- Update function
function ocean:update(dt)
  self.currentTime = self.currentTime + dt
  if self.currentTime > self.animationSpeed then
    self.currentTime = self.currentTime - self.animationSpeed
    self.frame = self.frame + 1
    if self.frame > #self.frames then
      self.frame = 1
    end
  end
end

-- Draw function
function ocean:draw()
  local frameX = (self.frames[self.frame] - 1) * self.frameWidth
  love.graphics.draw(self.image, frameX, 0, 0, love.graphics.getWidth() / self.frameWidth, love.graphics.getHeight() / self.frameHeight)
end

-- Example usage
local myOcean = ocean

function love.update(dt)
  myOcean:update(dt)
end

function love.draw()
  myOcean:draw()
end

