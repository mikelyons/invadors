
--[[
  editorui.lua

  The ui panel for a new object in the editor 
]]
--dependencies
local fanfic = require 'states/menu/fanfic'

local EditorUI = {}

function EditorUI:new(x,y, data)
  local panel = {}
  panel.data = data or {}

  panel.x = x or 0
  panel.y = y or 0
  panel.w = panel.data.w or 250
  panel.h = panel.data.h or 400
  -- panel.img = 100
  -- panel.quad = 100
  -- panel.id 100
  panel.colors = panel.data.p_color or {
    black = {0, 0, 0, 255},
    grey =  {150, 150, 150, 255},
    darkgrey =    {100, 100, 100, 255},
    verydarkgrey =    {55, 55, 55, 55},
    white = {255, 255, 255, 255},
    bg1 =    {100, 100, 100, 255},
    bg2 =    {55, 55, 55, 55},
    titlebr={150, 255, 255, 255}
  }
  panel.fields = {}

  function panel:newField(name, text, object)
    return {
      name = name,
      text = text,

      now = false,
      last = false,

    }
  end

  function panel:addField(name)
    print(Tlength(panel.fields))

    local thefield = self:newField(
      'defaultObject',
      'defaultText',
      {}
    )

    table.insert(panel.fields,
      self:newField(
        'defaultObject',
        'defaultText',
        {}
      )
    )
    -- FINISH TODO: get fields iterated over and drawn
    -- - get field adding all defaulted up
    print('Field added to fields table for editor ui [      ]')
    print(Tlength(panel.fields))
  end

  function panel:mousepressed(x,y, button , istouch) end
  function panel:mousereleased(x, y, button) end
  function panel:keypressed(key, code) end

  function panel:load()
    self:addField('testor')
  end
  function panel:update() end
  function panel:draw()
    -- save color used previously
    local _r, _g, _b, _a = love.graphics.getColor()

    -- create the panel bg and outline
    love.graphics.setColor(panel.colors.darkgrey)
    love.graphics.rectangle('fill', panel.x-5, panel.y-5, panel.w+10, panel.h+10)
    love.graphics.setColor(panel.colors.grey)
    love.graphics.rectangle('fill', panel.x, panel.y, panel.w, panel.h)

    -- create the titlebar
    love.graphics.setColor(panel.colors.titlebr)
    love.graphics.rectangle('fill',
      panel.x+1, panel.y+1,
      panel.w-2, 32
    )

    -- create the X button
    love.graphics.setColor(panel.colors.grey)
    love.graphics.rectangle('fill',
      panel.x + panel.w - 32,
      panel.y+4,
      30, --panel.w,
      28--panel.h
    )
    love.graphics.setColor(panel.colors.black)
		love.graphics.print("X",
      -- 200, 350
      panel.x+panel.w-32,
      panel.y+4
    )

    -- create the fields
    -- love.graphics.setColor(panel.colors.white)
    -- love.graphics.rectangle('fill',
    --   panel.x+4, panel.y+64,
    --   panel.w-8, 32
    -- )


    -- print('attempting to draw UI for panel fields')
    self:drawFields()
    -- for i, field in ipairs(fields) do
    -- end

    -- reset color used previously
    love.graphics.setColor(_r, _g, _b, _a)
  end
  function panel:drawFields()
    for i, field in ipairs(panel.fields) do
      print(i.." # Field: "..field.name)
    end
  end

  return panel
end

return EditorUI