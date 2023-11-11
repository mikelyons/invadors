--[[
  drawMan.lua

  A bunch of polygons that hopefully looka likea man.

  @TODO 
    - draw each body part separately

]]

local colors = {
  {255,209,127} -- flesh tone?
}


local Man = {}
-- rules of thumb - this should go in Entered State?
-- local centerx, centery = 100,100
  -- body thumb rule measures TODO improve and encapsulate
  local boxwidth = 300
  local boxheight = 80
  local centerx = camera.pos.x + screen_width/2 - (boxwidth/2)
  local centery = camera.pos.y + screen_height/2

  local head = {
    w = 128,
    h = 128,
    x = centerx + boxwidth/2,
    y = centery - 100,
  }
  local headw = 64
  local headh = 156

function Man:drawMan()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
  -- love.graphics.rectangle()
end

function Man:drawText()
    love.graphics.print("Mister Earl Jones",
      -- centerx+120, --x,
      -- centery+50, --, y,
      220, --x,
      50 --, y,
      -- nil, -- r,
      -- 20,-- sx,
      -- 20-- sy,
      -- ox,
      -- oy
    )
end

function Man:drawHead()
  -- head
  love.graphics.setColor(255,209,127)
  -- love.graphics.rectangle("fill", centerx + boxwidth/2, centery - 100, headw, headh)
  love.graphics.circle("fill",
    centerx + boxwidth/2,
    centery - 100,
    headw,
    headh
  )
  -- eye
  love.graphics.setColor(0,0,0)
  love.graphics.circle("fill",
    centerx + boxwidth/2 + 32,
    centery - 100 + 32,
    16,
    16
  )
  love.graphics.setColor(255,209,127)
  love.graphics.circle("fill",
    centerx + boxwidth/2 + 32,
    centery - 100 + 37,
    16,
    16
  )
  -- love.graphics.circle("fill",
  --   centerx + boxwidth/2,
  --   centery - 100,
  --   headw,
  --   headh
  -- )

end
function Man:drawChest()
    -- chest shape
		love.graphics.setColor(255,209,127)
    love.graphics.rectangle("fill",
      centerx,
      centery,
      boxwidth,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx,
      centery,
      boxwidth,
      boxheight
    )
end
function Man:drawAbdmen()
    -- Abdomen shape
    love.graphics.rectangle("fill",
      centerx + (boxwidth*0.1),
      centery + boxheight/2,
      boxwidth*0.8,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx + (boxwidth/4),
      centery + boxheight,
      boxwidth/2,
      boxheight
    )
    love.graphics.rectangle("fill",
      centerx + (boxwidth/3),
      centery + boxheight*2,
      boxwidth/3,
      boxheight
    )
end
function Man:drawShading()
    -- muscle shadows (pex)
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery+10,
      boxwidth-6,
      (10)
    )
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery,
      boxwidth-4,
      (20)
    )
    love.graphics.rectangle("line",
      centerx,
      centery+40,
      boxwidth-2,
      (40)
    )
    -- armpit shadow
    love.graphics.rectangle("fill",
      centerx+3,
      centery+3,
      32,
      32
    )

    -- muscle shadows (abs)
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery+10,
      boxwidth/6,
      (10)
    )
		love.graphics.setColor(235,189,97)
    love.graphics.rectangle("line",
      centerx,
      centery,
      boxwidth/4,
      (20)
    )
    love.graphics.rectangle("line",
      centerx+40,
      centery+40,
      boxwidth/2,
      (40)
    )
    -- armpit shadow
    love.graphics.rectangle("fill",
      centerx+3,
      centerx*2-300,
      32,
      32
    )
end
function Man:drawTattoo()
    -- tattoo
		-- love.graphics.setColor(245,159,97)
    local tatbarh = 4
		love.graphics.setColor(0,5,55)
    love.graphics.rectangle("fill",
      centerx+80,
      centery+30,
      64,
      tatbarh
    )
    love.graphics.rectangle("fill",
      centerx+80,
      centery+40,
      64,
      tatbarh
    )
    love.graphics.rectangle("fill",
      centerx+80,
      centery+50,
      64,
      tatbarh
    )
    
		love.graphics.setColor(0,5,55)
    love.graphics.rectangle("fill",
      centerx+180,
      centery+30,
      tatbarh,
      64
    )
    love.graphics.rectangle("fill",
      centerx+190,
      centery+40,
      tatbarh,
      64
    )
    love.graphics.rectangle("fill",
      centerx+200,
      centery+50,
      tatbarh,
      64
    )
    love.graphics.print("raint",
      centerx+120, --x,
      centery+50 --, y,
      -- r,
      -- sx,
      -- sy,
      -- ox,
      -- oy
    )
    love.graphics.print("r\na\ni\nn\nt",
      centerx+160, --x,
      centery+50 --, y,
      -- r,
      -- sx,
      -- sy,
      -- ox,
      -- oy
    )

end
function Man:drawScars()
    -- scars
    s1w = hamster:getWidth()
    s1h = hamster:getHeight()
    -- s1a= love.timer.getTime() * 2*math.pi / 2.5 -- Rotate one turn per 2.5 seconds.
    s1a=1
    love.graphics.draw(scarA,
      -- 100,
      -- 100,
      centerx+210, --x,
      centery+90, --, y,
      s1a,
      0.5,0.5,
      s1w/2, s1h/2
    )
    love.graphics.draw(scarB,
      -- 100,
      -- 100,
      centerx+170, --x,
      centery+90, --, y,
      s1a/2,
      0.9,0.9,
      s1w/2, s1h/2
    )
end
function Man:drawNipples()
    -- nipples
		love.graphics.setColor(245,159,97)
    love.graphics.rectangle("fill",
      centerx+40,
      centery+40,
      32,
      32
    )
    love.graphics.rectangle("fill",
      centerx*2-300,
      centery+40,
      32,
      32
    )
    -- love.graphics.rectangle("fill",
    --   centerx,
    --   centery,
    --   boxwidth,
    --   (80)
    -- )

    -- pasties
		love.graphics.setColor(0,0,55)
    love.graphics.print("X",
      centerx+40 + 8,
      centery+40 + 8,
      0,-- r,
      2,-- sx,
      2-- sy,
      -- ox,
      -- oy
    )
    love.graphics.print("x",
      centerx*2-300 + 8,
      centery+40 + 8,
      0, -- r,
      2, -- sx,
      2-- sx,
      -- sy,
      -- ox,
      -- oy
    )
end

function Man:drawTorso()

end

return Man
