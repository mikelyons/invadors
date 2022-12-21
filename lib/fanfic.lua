--[[
Fänfic: Functional and Needed Fully Insertable Characters
A module for textboxes in Löve.
version 0.2

Copyright (c) 2011 Teddy Sudol

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
--]]
--[[
this version altered by Mike Lyons
Additions:
  - support for space characters in field string and display
--]]

--steal some stuff from the globals here, if needed
local type = type
local string = string
local love = love
local setmetatable = setmetatable
local tostring = tostring
--local print = print

module(...)

local tbox = {}
tbox.__index = tbox

function new(x,y, label, password, font, size)
	local tb = {}

	tb.text = ""

	tb.x, tb.y = x, y
	tb.pos = {x,y}

	tb.label = label

	tb.cursor = "|"
	tb.cursorDelay = .5 --blink!
	tb.cursorCounter = 0
	tb.showCursor = true

	tb.password = password --boolean

	tb.oldFont = love.graphics.getFont()
	if size and type(font) == 'string' then --they sent in a filename and a font size, presumably
		tb.font = love.graphics.newFont(font, size)
	else --using default font with a new size.
		tb.font = love.graphics.newFont(font)
	end

	tb.width = tb.font:getWidth("M")*12 --assuming 12 characters (using M) wide
	tb.height = tb.font:getHeight()

	tb.finished = false --set to true when the user is done entering info
	return setmetatable(tb, tbox)
end

function tbox:update(dt)
	--update is entirely for the blinking cursor. go figure.
	if self.finished then
		dt = 0
		self.showCursor = false
	end
	self.cursorCounter = self.cursorCounter + dt
	if self.cursorCounter > self.cursorDelay then
		self.showCursor = not self.showCursor
		self.cursorCounter = 0
	end
end

function tbox:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(self.font)
	love.graphics.rectangle('fill', self.x,self.y, self.width, self.height)

	love.graphics.setColor(0,0,0)
	if self.password then
		love.graphics.print(string.rep('*', #self.text), self.x, self.y)
	else
		love.graphics.print(self.text, self.x, self.y)
	end
	if self.showCursor then love.graphics.print(self.cursor, self.x+self.font:getWidth(self.text), self.y-2) end

	love.graphics.setFont(self.labelFont)
	love.graphics.setColor(255,255,255)--setColor(self.labelColor)
	love.graphics.print(self.label, self.x, self.y-self.font:getHeight())

	love.graphics.setFont(self.oldFont)
end

function tbox:keypressed(key, unicode)
	if self.finished then return end
	if key == 'backspace' then
		if self.text:len() > 0 then
			self.text = self.text:sub(1,-2) --removes the last character from text.  Technically just grabs the string up until the last character.
		end
	elseif key == 'return' then
		self.finished = true
	elseif key == 'space' then
		self.text = self.text..' '
	elseif key:len() == 1 then --it's a single letter
		self.text = self.text..string.char(unicode)
		--using the unicode allows any character to be entered.  If just the key is used, there is a massive headache from using the shift keys, etc.
	end
end

function tbox:enteredText()
	if self.finished then return self.text
	else return nil
	end
end
	
