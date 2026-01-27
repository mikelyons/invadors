--[[
  video_slideshow.lua

  A system for playing image sequences as animated backgrounds.
  Works like a flipbook - cycles through numbered PNG frames.

  ORIGIN: Extracted from states/generate/generate.lua (lines 39-73)
  STATUS: Experimental, not actively used

  TODO: Expand documentation in future
  - Add frame rate control
  - Add pause/resume functionality
  - Add callback for sequence completion
  - Consider memory optimization for large sequences
  - Add lazy loading option for memory-constrained devices

  ============================================================
  ASSET DOCUMENTATION (for repo cleanup)
  ============================================================

  IMAGE FILES:
    Location: assets/imageSequence/
    Format:   PNG
    Naming:   scene00001.png through scene00748.png (748 frames)
    Pattern:  scene%05d.png (5-digit zero-padded)

  ESTIMATED SIZE:
    748 PNG frames - likely 100MB+ depending on resolution

  TO REMOVE ASSETS:
    rm -rf assets/imageSequence/

  ============================================================
]]

local VideoSlideshow = {}
VideoSlideshow.__index = VideoSlideshow

--[[
  Create a new video slideshow

  @param config table:
    - directory: string - path to image sequence folder
    - prefix: string - filename prefix (default: "scene")
    - extension: string - file extension (default: "png")
    - frameCount: number - total number of frames
    - loop: boolean - whether to loop (default: true)
    - fallbackImage: string - path to fallback/default image

  @return VideoSlideshow instance
]]
function VideoSlideshow:new(config)
    local self = setmetatable({}, VideoSlideshow)

    self.directory = config.directory or "assets/imageSequence/"
    self.prefix = config.prefix or "scene"
    self.extension = config.extension or "png"
    self.frameCount = config.frameCount or 1
    self.loop = config.loop ~= false
    self.fallbackImage = config.fallbackImage

    self.frames = {}
    self.currentFrame = 1
    self.loaded = false
    self.playing = false

    -- Optional: fallback image when slideshow not loaded
    if self.fallbackImage then
        self.fallback = love.graphics.newImage(self.fallbackImage)
    end

    return self
end

--[[
  Load all frames into memory

  WARNING: This loads ALL frames at once. For large sequences (700+ frames),
  this will consume significant memory. Consider lazy loading for production.

  @return boolean - true if loading succeeded
]]
function VideoSlideshow:load()
    print(string.format("VideoSlideshow: Loading %d frames from %s",
        self.frameCount, self.directory))

    for i = 1, self.frameCount do
        local filename = self.prefix .. string.format("%05d", i) .. "." .. self.extension
        local path = self.directory .. filename

        local success, result = pcall(function()
            return love.graphics.newImage(path)
        end)

        if success then
            self.frames[i] = result
            if i % 100 == 0 then
                print(string.format("VideoSlideshow: Loaded frame %d/%d", i, self.frameCount))
            end
        else
            print(string.format("VideoSlideshow: Failed to load %s - %s", path, tostring(result)))
            return false
        end
    end

    self.loaded = true
    self.playing = true
    print("VideoSlideshow: All frames loaded successfully")
    return true
end

--[[
  Advance to the next frame

  Call this in your update() loop or draw() for frame-rate-based playback.
]]
function VideoSlideshow:nextFrame()
    if not self.loaded or not self.playing then return end

    self.currentFrame = self.currentFrame + 1

    if self.currentFrame > self.frameCount then
        if self.loop then
            self.currentFrame = 1
        else
            self.currentFrame = self.frameCount
            self.playing = false
        end
    end
end

--[[
  Draw the current frame

  @param x number - X position (default: 0)
  @param y number - Y position (default: 0)
  @param ... - additional love.graphics.draw arguments (rotation, scale, etc.)
]]
function VideoSlideshow:draw(x, y, ...)
    x = x or 0
    y = y or 0

    if self.loaded and self.frames[self.currentFrame] then
        love.graphics.draw(self.frames[self.currentFrame], x, y, ...)
    elseif self.fallback then
        love.graphics.draw(self.fallback, x, y, ...)
    end
end

--[[
  Update and draw in one call (convenience method)

  Advances frame and draws - suitable for calling from draw() loop
  for frame-rate-dependent playback.
]]
function VideoSlideshow:drawAndAdvance(x, y, ...)
    self:draw(x, y, ...)
    self:nextFrame()
end

-- Playback controls
function VideoSlideshow:play() self.playing = true end
function VideoSlideshow:pause() self.playing = false end
function VideoSlideshow:stop() self.playing = false; self.currentFrame = 1 end
function VideoSlideshow:reset() self.currentFrame = 1 end
function VideoSlideshow:isPlaying() return self.playing end
function VideoSlideshow:getCurrentFrame() return self.currentFrame end

--[[
  Unload all frames to free memory
]]
function VideoSlideshow:unload()
    self.frames = {}
    self.loaded = false
    self.playing = false
    self.currentFrame = 1
    collectgarbage("collect")
    print("VideoSlideshow: Frames unloaded")
end

return VideoSlideshow

--[[
  USAGE EXAMPLE:

  local VideoSlideshow = require('src/experimental/video_slideshow')

  local intro = VideoSlideshow:new({
      directory = "assets/imageSequence/",
      prefix = "scene",
      frameCount = 748,
      loop = true,
      fallbackImage = "assets/galaxy.png"
  })

  function love.load()
      intro:load()
  end

  function love.draw()
      intro:drawAndAdvance(0, 0)
  end

  function love.keypressed(key)
      if key == "space" then
          if intro:isPlaying() then
              intro:pause()
          else
              intro:play()
          end
      end
  end
]]
