local b = {}

-- Block functions

function b:addBlock(x,y,w,h)
  local block = {x=x,y=y,w=w,h=h}
  local blocks = {} 
  blocks[#blocks+1] = block
  -- world:add(block, x,y,w,h) -- Add the block of your choice to the world
end

-- helper function
function b:drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

function b:drawBlocks()
  for _,block in ipairs(blocks) do
    self.drawBox(block, 255,0,0)
  end
end


return b
