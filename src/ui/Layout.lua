--[[
  Layout.lua

  Layout helpers for positioning UI elements.
  Provides functions for common layout patterns like centering,
  stacking, and grid arrangements.

  Usage:
    local Layout = require('src/ui/Layout')

    -- Center elements vertically
    Layout.verticalCenter(buttons, {
      startY = 200,
      spacing = 16,
    })

    -- Create a grid layout
    Layout.grid(items, {
      columns = 3,
      cellWidth = 100,
      cellHeight = 100,
    })
]]

local Theme = require('src/ui/theme')

local Layout = {}

--- Get window dimensions
-- @return number, number width, height
function Layout.getWindowSize()
  return love.graphics.getWidth(), love.graphics.getHeight()
end

--- Center a single element horizontally in the window
-- @param element table Element with x, width properties
-- @param containerWidth number (optional) Container width, defaults to window width
function Layout.centerHorizontal(element, containerWidth)
  containerWidth = containerWidth or love.graphics.getWidth()
  element.x = (containerWidth - element.width) / 2
end

--- Center a single element vertically in the window
-- @param element table Element with y, height properties
-- @param containerHeight number (optional) Container height, defaults to window height
function Layout.centerVertical(element, containerHeight)
  containerHeight = containerHeight or love.graphics.getHeight()
  element.y = (containerHeight - element.height) / 2
end

--- Center a single element both horizontally and vertically
-- @param element table Element with x, y, width, height properties
-- @param containerWidth number (optional) Container width
-- @param containerHeight number (optional) Container height
function Layout.center(element, containerWidth, containerHeight)
  Layout.centerHorizontal(element, containerWidth)
  Layout.centerVertical(element, containerHeight)
end

--- Arrange elements in a vertical stack, centered horizontally
-- @param elements table Array of elements with setPosition(x, y) method or x, y properties
-- @param options table Configuration options
--   - startY (number, optional): Starting Y position (default: centers the stack)
--   - spacing (number, optional): Space between elements (default from theme)
--   - centerX (number, optional): X position to center on (default: window center)
function Layout.verticalCenter(elements, options)
  options = options or {}
  local spacing = options.spacing or Theme.spacing.md
  local ww, wh = Layout.getWindowSize()
  local centerX = options.centerX or (ww / 2)

  -- Calculate total height of all elements
  local totalHeight = 0
  for i, elem in ipairs(elements) do
    totalHeight = totalHeight + (elem.height or 0)
    if i < #elements then
      totalHeight = totalHeight + spacing
    end
  end

  -- Calculate starting Y position
  local startY = options.startY or ((wh - totalHeight) / 2)
  local currentY = startY

  -- Position each element
  for _, elem in ipairs(elements) do
    local x = centerX - (elem.width or 0) / 2

    if elem.setPosition then
      elem:setPosition(x, currentY)
    else
      elem.x = x
      elem.y = currentY
    end

    currentY = currentY + (elem.height or 0) + spacing
  end
end

--- Arrange elements in a horizontal row, centered vertically
-- @param elements table Array of elements
-- @param options table Configuration options
--   - startX (number, optional): Starting X position (default: centers the row)
--   - spacing (number, optional): Space between elements
--   - centerY (number, optional): Y position to center on
function Layout.horizontalCenter(elements, options)
  options = options or {}
  local spacing = options.spacing or Theme.spacing.md
  local ww, wh = Layout.getWindowSize()
  local centerY = options.centerY or (wh / 2)

  -- Calculate total width of all elements
  local totalWidth = 0
  for i, elem in ipairs(elements) do
    totalWidth = totalWidth + (elem.width or 0)
    if i < #elements then
      totalWidth = totalWidth + spacing
    end
  end

  -- Calculate starting X position
  local startX = options.startX or ((ww - totalWidth) / 2)
  local currentX = startX

  -- Position each element
  for _, elem in ipairs(elements) do
    local y = centerY - (elem.height or 0) / 2

    if elem.setPosition then
      elem:setPosition(currentX, y)
    else
      elem.x = currentX
      elem.y = y
    end

    currentX = currentX + (elem.width or 0) + spacing
  end
end

--- Arrange elements in a grid
-- @param elements table Array of elements
-- @param options table Configuration options
--   - columns (number): Number of columns
--   - cellWidth (number, optional): Width of each cell
--   - cellHeight (number, optional): Height of each cell
--   - startX (number, optional): Starting X position
--   - startY (number, optional): Starting Y position
--   - spacingX (number, optional): Horizontal spacing
--   - spacingY (number, optional): Vertical spacing
--   - centerInCell (boolean, optional): Center elements within their cells
function Layout.grid(elements, options)
  options = options or {}
  local columns = options.columns or 3
  local cellWidth = options.cellWidth or Theme.button.width
  local cellHeight = options.cellHeight or Theme.button.height
  local startX = options.startX or 0
  local startY = options.startY or 0
  local spacingX = options.spacingX or Theme.spacing.md
  local spacingY = options.spacingY or Theme.spacing.md
  local centerInCell = options.centerInCell ~= false

  for i, elem in ipairs(elements) do
    local col = (i - 1) % columns
    local row = math.floor((i - 1) / columns)

    local cellX = startX + col * (cellWidth + spacingX)
    local cellY = startY + row * (cellHeight + spacingY)

    local x, y
    if centerInCell then
      x = cellX + (cellWidth - (elem.width or 0)) / 2
      y = cellY + (cellHeight - (elem.height or 0)) / 2
    else
      x = cellX
      y = cellY
    end

    if elem.setPosition then
      elem:setPosition(x, y)
    else
      elem.x = x
      elem.y = y
    end
  end
end

--- Create a centered grid that fills available space
-- @param elements table Array of elements
-- @param options table Configuration options (same as grid, plus:)
--   - containerWidth (number, optional): Container width
--   - containerHeight (number, optional): Container height
function Layout.centeredGrid(elements, options)
  options = options or {}
  local columns = options.columns or 3
  local cellWidth = options.cellWidth or Theme.button.width
  local cellHeight = options.cellHeight or Theme.button.height
  local spacingX = options.spacingX or Theme.spacing.md
  local spacingY = options.spacingY or Theme.spacing.md

  local ww = options.containerWidth or love.graphics.getWidth()
  local wh = options.containerHeight or love.graphics.getHeight()

  local rows = math.ceil(#elements / columns)

  -- Calculate total grid dimensions
  local gridWidth = columns * cellWidth + (columns - 1) * spacingX
  local gridHeight = rows * cellHeight + (rows - 1) * spacingY

  -- Calculate centered starting position
  options.startX = (ww - gridWidth) / 2
  options.startY = (wh - gridHeight) / 2

  Layout.grid(elements, options)
end

--- Stack elements from top with fixed spacing
-- @param elements table Array of elements
-- @param options table Configuration options
--   - startX (number): Starting X position
--   - startY (number): Starting Y position
--   - spacing (number, optional): Space between elements
function Layout.stackVertical(elements, options)
  options = options or {}
  local startX = options.startX or 0
  local startY = options.startY or 0
  local spacing = options.spacing or Theme.spacing.md

  local currentY = startY

  for _, elem in ipairs(elements) do
    if elem.setPosition then
      elem:setPosition(startX, currentY)
    else
      elem.x = startX
      elem.y = currentY
    end

    currentY = currentY + (elem.height or 0) + spacing
  end
end

--- Stack elements from left with fixed spacing
-- @param elements table Array of elements
-- @param options table Configuration options
--   - startX (number): Starting X position
--   - startY (number): Starting Y position
--   - spacing (number, optional): Space between elements
function Layout.stackHorizontal(elements, options)
  options = options or {}
  local startX = options.startX or 0
  local startY = options.startY or 0
  local spacing = options.spacing or Theme.spacing.md

  local currentX = startX

  for _, elem in ipairs(elements) do
    if elem.setPosition then
      elem:setPosition(currentX, startY)
    else
      elem.x = currentX
      elem.y = startY
    end

    currentX = currentX + (elem.width or 0) + spacing
  end
end

--- Calculate bounds that contain all elements
-- @param elements table Array of elements with x, y, width, height
-- @return number, number, number, number x, y, width, height
function Layout.getBounds(elements)
  if #elements == 0 then
    return 0, 0, 0, 0
  end

  local minX, minY = math.huge, math.huge
  local maxX, maxY = -math.huge, -math.huge

  for _, elem in ipairs(elements) do
    local x = elem.x or 0
    local y = elem.y or 0
    local w = elem.width or 0
    local h = elem.height or 0

    minX = math.min(minX, x)
    minY = math.min(minY, y)
    maxX = math.max(maxX, x + w)
    maxY = math.max(maxY, y + h)
  end

  return minX, minY, maxX - minX, maxY - minY
end

return Layout
