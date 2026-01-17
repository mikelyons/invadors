--[[
  uiTest.lua

  a uiTest for adding a new gamestate
  Here we test out ui libraries like SUI
    X SUIT already installed in /lib ? no?
    - Gspot working!!!!! @TODO do more with it
      - https://notabug.org/pgimeno/Gspot/src/master/main.lua

      @TODO - fix the value input in gpot2 so text input works
      use gui libraries in character creation
      @TODO - fix backspace: https://love2d.org/wiki/utf8 - https://www.lua.org/manual/5.3/manual.html#6.5
]]

-- print(love._version_major)
-- print(love._version_minor)
-- print(love._version_revision)
if DEBUG_LOGGING_LOADING then
	print('uiTest.lua -> ')
  print('uiTest -> ')
end

love.keyboard.setTextInput( true )
-- love.keyboard.setTextInput( true )


-- dependencies
font = love.graphics.newFont(192)
gui = require('lib/gspot/Gspot') -- import the library
-- gui = require('lib/gspot2/Gspot') -- import the library

-- set up the color numbers based on LOVE version
-- local DIV = love.getVersion() >= 11 and 1/255 or 1
local DIV = love._version_minor >= 11 and 1/255 or 1

-- ascii = require 'states/uiTest/ascii'
ascii = require 'states/uiTest/asciiart'
require 'states/uiTest/elements'

-- registering the gamestate
local UiTest = Game:addState('uiTest')


function UiTest:enteredState()
  if DEBUG_LOGGING_ON and false then
    print(string.format("ENTER uiTest STATE - %s \n", os.date()))
  end

	local element = gui:button('raint', {x=400,y=400}, nil)


	love.graphics.setFont(font)
	love.graphics.setColor(255 * DIV, 192 * DIV, 0 * DIV, 128 * DIV) -- just setting these so we know the gui isn't stealing our thunder

	sometext = "raint"

	local textout = gui:typetext(
    sometext,
    {y = 20, w = screen_width-20}
  )


  -- begin example

  love.keyboard.setKeyRepeat(500, 250)
  love.graphics.setFont(font)
  love.graphics.setColor(255, 192, 0, 128) -- just setting these so we know the gui isn't stealing our thunder

  _G.ui.lorem()


  -- button
  _G.ui.button()
  
  -- image
  _G.ui.image()
  
  -- hidden element
  local hidden = gui:hidden('', {128, 128, 128, 128}) -- creating a hidden element, to see it at work
  hidden.tip = "Can't see me, but I still respond"
  
  -- elements' children will be positioned relative to their parent's position
  _G.ui.group1()
  
  -- another group, with various behaviours
  _G.ui.group2()

  
  -- initialize element.shape to 'circle' by specifying pos.r -- pos.w and pos.h will be set accordingly
  local checkbox = gui:checkbox(nil, {r = 8}, scrollgroup) -- scrollgroup.scrollh.values.max, scrollgroup.scrollv.values.max will be updated when a child is added to scrollgroup
  checkbox.click = function(this)
	  gui[this.elementtype].click(this) -- calling option's base click() to preserve default functionality, as we're overriding a reserved behaviour
	  if this.value then this.style.fg = {255, 128, 0, 255}
	  else this.style.fg = {255, 255, 255, 255} end
  end
  local checkboxlabel = gui:text('check', {x = 16}, checkbox, true) -- using the autosize flag to resize the element's width to fit the text
  checkboxlabel.click = function(this, x, y)
	  this.parent:click()
  end

  -- local loader
  _G.ui.loader()

  -- additional scroll controls
  button = gui:button('up', {group2.pos.w, 0}, group2) -- a small button attached to the scrollgroup's group, because all of a scrollgroup's children scroll
  button.click = function(this)
	  local scroll = scrollgroup.scrollv
	  scroll.values.current = math.max(scroll.values.min, scroll.values.current - scroll.values.step) -- decrement scrollgroup.scrollv.values.current by scrollgroup.scrollv.values.step, and the slider will go up a notch
	  scroll:drop()
  end
  button = gui:button('dn', {group2.pos.w, group2.pos.h + gui.style.unit}, group2)
  button.click = function(this)
	  local scroll = scrollgroup.scrollv
	  scroll.values.current = math.min(scroll.values.max, scroll.values.current + scroll.values.step) -- this one increment's the scrollbar's values.current, moving the slider down a notch
	  scroll:drop()
  end

  -- text input
  _G.ui.textinput()


  -- easy custom gui element
_G.ui.customelement()

  -- or if you want more control
  gui.mostbasic = {}
  gui.mostbasic.load = function(this, Gspot, label, pos, parent)
	  local element = Gspot:element('group', label, pos, parent) -- Gspot:element(elementtype, label, pos, parent) gives the element its required values and inheritance. elementtype must be an existing type, or it won't work
	  return Gspot:add(element) -- Gspot:add() adds it to Gspot.elements, and returns the new element
  end
  gui.mostbasic.update = function(this, dt) end -- dt is passed along by Gspot:update(dt)
  gui.mostbasic.draw = function(this, pos) end -- pos is the element's absolute position, supplied by Gspot:draw()

  --show, hide, and update
  text = gui:text('Hit F to show/hide', {love.graphics.getWidth() - 128, gui.style.unit, 128, gui.style.unit}) -- a hint (see love.keypressed() below)
  showhider = gui:group('Mouse Below', {love.graphics.getWidth() - 128, gui.style.unit * 2, 128, 64})
  counter = gui:text('0', {0, gui.style.unit, 128, 0}, showhider)
  counter.count = 0
  counter.update = function(this, dt) -- set an update function, which will be called every frame, unless we also specify element.updateinterval
	  if this.parent == gui.mousein then
		  this.count = this.count + dt
		  if this.count > 1 then this.count = 0 end
		  this.label = this.count
	  end
  end

  -- end example


	local button = gui:button('Hello', {128, 128, 128, 16}) -- or {0.5, 0.5, 0.5, 0.063} for 11.x
	button.click = function(this)
		button = gui:button('Hello', {328, 128, 128, 16}) -- or {0.5, 0.5, 0.5, 0.063} for 11.x
		button.click = function(this)
			button = gui:button('Hello', {328, 228, 128, 16}) -- or {0.5, 0.5, 0.5, 0.063} for 11.x
		end
		print('Hello!')
	end

end

-- local slider = {value = 1, min = 0, max = 2}

function UiTest:update(dt)
	gui:update(dt)
end

function UiTest:draw()
	local bg = 'OBEY'
	love.graphics.print(
	'Background',--bg,
	0, 140, math.pi / 4, 1, 1)

	-- love.graphics.print("text box", 200, 350)
  -- print('DRAW')

  	gui:draw()


	love.graphics.print(
	'foreground',--bg,
	320, 140, math.pi / 4, 1, 1)
  -- love.graphics.setColor(255, 255, 255, 255)

end

function UiTest:exitedState()
  -- love.graphics.clear()
end

-- input
function UiTest:textinput(key)
	if gui.focus then
-- only sending input to the gui if we're not using it for something else
		gui:textinput(key)
	end
end
function UiTest:mousepressed(x,y, button , istouch) gui:mousepress(x, y, button) end
function UiTest:mousereleased(x, y, button) gui:mouserelease(x, y, button) end
function UiTest:wheelmoved(x, y, button) gui:mousewheel(x, y) end

function UiTest:keypressed(key, code)
	if gui.focus then
		gui:keypress(key) -- only sending input to the gui if we're not using it for something else
	else
		if key == 'return' then -- binding enter key to input focus
			input:focus()
		elseif key == 'f' then -- toggle show-hider
			if showhider.display then showhider:hide() else showhider:show() end
		else
			gui:feedback(key) -- why not
		end
	end

--   if key == ('escape') then love.event.push('quit') end
  if key == ('escape') then
    -- self:popState('uiTest')
    self:gotoState('menu')
    -- love.event.push('quit')
  end
end