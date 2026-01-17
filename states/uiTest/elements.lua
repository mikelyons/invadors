--[[
  elements.lua

  This file will build up ui element groups for use in the uitest.lua
]]

_G.ui = {}

function _G.ui.lorem(x, y)
  sometext = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  local textout = gui:typetext(sometext, {y = 32, w = 128})
end

function _G.ui.button()
  local button = gui:button('A Button', {x = 128, y = gui.style.unit, w = 128, h = gui.style.unit}) -- a button(label, pos, optional parent) gui.style.unit is a standard gui unit (default 16), used to keep the interface tidy
  button.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
	  gui:feedback('Clicky')
  end
end


function _G.ui.image()
  local image = gui:image('An Image', {160, 32, 0, 0}, nil, 'img.png') -- an image(label, pos, parent, love.image or path)
  image.click = function(this, x, y)
	  gui:feedback(tostring(this.pos))
  end
  image.enter = function(this) this.Gspot:feedback("I'm In!") end -- every element has a reference to the gui instance which created it
  image.leave = function(this) this.Gspot:feedback("I'm Out!") end
end

function _G.ui.group1()
  group1 = gui:collapsegroup('Group 1', {gui.style.unit, gui.style.unit * 3, 128, gui.style.unit}) -- group(label, pos, optional parent)
  group1.style.fg = {255, 192, 0, 255}
  group1.tip = 'Drag and drop' -- add a tooltip
  group1.drag = true -- respond to default drag behaviour
  group1.drop = function(this, bucket) -- respond to drop event
	  if bucket then gui:feedback('Dropped on '..tostring(bucket))
	  else gui:feedback('Dropped on nothing') end
  end
  -- option (must have a parent)
  for i = 1, 3 do
	  option = gui:option('Option '..i, {0, gui.style.unit * i, 128, gui.style.unit}, group1, i) -- option(label, pos, parent, value) option stores this.value in this.parent.value when clicked, and is selected if this.value == this.parent.value
	  option.tip = 'Select '..option.value
  end
end

function _G.ui.group2()
  group2 = gui:group('Group 2', {gui.style.unit, 128, 256, 256})
  group2.drag = true
  group2.tip = 'Drag, right-click, and catch'
  group2.rclick = function(this) -- respond to right-click event by creating a button.
	  gui:feedback('Right-click')
	  local button = gui:button('A dynamic button', {love.mouse.getX(), love.mouse.getY(), 128, gui.style.unit}) -- button's parent will be the calling element
	  button.click = function(this) -- temp button to click before removed itself
		  gui:feedback('I\'ll be back!')
		  gui:rem(this)
	  end
  end
  group2.catch = function(this, ball) -- respond when an element is dragged and then dropped on this element
	  gui:feedback('Caught '..ball:type())
  end
  -- scrollgroup's children, excepting its scrollbar, will scroll
  scrollgroup = gui:scrollgroup(nil, {0, gui.style.unit, 256, 256}, group2) -- scrollgroup will create its own scrollbar
  scrollgroup.scrollh.tip = 'Scroll (mouse or wheel)' -- scrollgroup.scrollh is the horizontal scrollbar
  scrollgroup.scrollv.tip = scrollgroup.scrollh.tip -- scrollgroup.scrollv is the vertical scrollbar
  --scrollgroup.scroller:setshape('circle') -- to set a round handle
  scrollgroup.scrollh.drop = function(this) gui:feedback('Scrolled to : '..this.values.current..' / '..this.values.min..' - '..this.values.max) end
  scrollgroup.scrollv.drop = scrollgroup.scrollh.drop
end


function _G.ui.loader()
  local loader = gui:progress('Loading', {x = 64, y = 16, w = 64}, scrollgroup)
  loader.updateinterval = 0.25 -- just setting this so we can see the progress bar at work
  loader.done = function(this)
	  done = this:replace(gui:feedback('Done', {0, this.pos.y}, this.parent, false)) -- replace with a new element at the same level in draw order
  end
  
  for i = 1, 8 do
	  loader:add(function() return scrollgroup:addchild(gui:text(sometext, {w = 128}), 'grid') end)
	  --gui:text(sometext, {w = 128}) -- if not autosize, Gspot wraps text to element.pos.w and adjusts element.pos.h to fit it in
	  --element:addchild(element, 'vertical') -- using the autostack flag to reposition below existing child elements
	  --the two lines above accomplish the same as gui:text(str, {y = scrollgroup:getmaxh(), w = 128}, scrollgroup)
  end
end

function _G.ui.textinput()
  input = gui:input('Chat', {64, love.graphics.getHeight() - 32, 256, gui.style.unit})
  input.keydelay = 500 -- these two are set by default for input elements, same as doing love.setKeyRepeat(element.keydelay, element.keyrepeat) but Gspot will return to current keyrepeat state when it loses focus
  input.keyrepeat = 200 -- keyrepeat is used as default keydelay value if not assigned as above. use element.keyrepeat = false to disable repeating
  input.done = function(this) -- Gspot calls element:done() when you hit enter while element has focus. override this behaviour with element.done = false
	  gui:feedback('I say '..this.value)
	  this.value = ''
	  this.Gspot:unfocus()
  end
  button = gui:button('Speak', {input.pos.w + gui.style.unit, 0, 64, gui.style.unit}, input) -- attach a button
  button.click = function(this)
	  this.parent:done()
  end
end

function _G.ui.customelement()
  gui.boxy = function(this, label, pos, parent) -- careful not to override existing element types, and remember we're inside the gui's scope now
	  local group = this:group(label, pos, parent) -- using the easy  method, our custom element should be based on an existing element type
	  group.tip = 'Drag, and right-click to spawn'
	  group.drag = true
	  group.rclick = function(this) gui:boxy('More custom goodness', {love.mouse.getX(), love.mouse.getY(), 128, 64}) end -- boxy will spawn more windows

	  local x = this:button('X', {x = group.pos.w - this.style.unit, y = 0, w = this.style.unit, h = this.style.unit}, group) -- adding a control
	  x.click = function(this) this.Gspot:rem(this.parent) end -- which removes this boxy

	  return group -- return the element
  end
  boxy = gui:boxy('Custom goodness', {256, 256, 128, 64}) -- now make one of our windows
end

function _G.ui.pizza()
	local pizza = gui:image(
    -- 'An Image',
    nil,
    {160, 32, 0, 0},
    nil,
    'assets/items/pizza_0.png'
  ) -- an image(label, pos, parent, love.image or path)
	pizza.click = function(this, x, y)
		-- gui:feedback(tostring(this.pos))
		gui:feedback("Gimmie Pizza!!!")
	end
	pizza.enter = function(this) this.Gspot:feedback("Pizza!") end -- every element has a reference to the gui instance which created it
	pizza.leave = function(this) this.Gspot:feedback("...") end
  pizza.tip = 'You\'re making me so hongory'
end