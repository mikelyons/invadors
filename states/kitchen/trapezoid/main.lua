
local perspective = love.graphics.newShader [[

  uniform ArrayImage MainTex;

  #ifdef VERTEX
    vec4 position( mat4 transform_projection, vec4 vertex_position )
    {
      VaryingTexCoord.xyz *= VaryingTexCoord.w; 
      return transform_projection * vertex_position;
    }
  #endif

  #ifdef PIXEL
    void effect() {
      love_PixelColor = Texel(MainTex, VaryingTexCoord.xyz / VaryingTexCoord.w);
    }
  #endif
  
]]
local width_top, width_bottom = 300, 600
local height = 300
local layer = 0
local toggle = -1
local vertexFormat = {
  {"VertexPosition", "float", 2},
  {"VertexTexCoord", "float", 4}}
  
-- For Trapeziods with at least 2 parallel lines, 
-- you can simply use the Width (or Height) as the W value for the Shader  

local uv = {
    { u = 0, v = 0, w = width_top},
    { u = 1, v = 0, w = width_top},
    { u = 1, v = 1, w = width_bottom },
    { u = 0, v = 1, w = width_bottom }
  }

local mesh = love.graphics.newMesh( vertexFormat, {
  --  X,                Y,        U,        V,        Z,      W
    { -width_top/2,     0,        uv[1].u,  uv[1].v,  layer,  1 }, -- Top Left Corner    
    {  width_top/2,     0,        uv[2].u,  uv[2].v,  layer,  1 }, -- Top Right Corner   
    {  width_bottom/2,  height,   uv[3].u,  uv[3].v,  layer,  1 }, -- Bottom Right Corner  
    { -width_bottom/2,  height,   uv[4].u,  uv[4].v,  layer,  1 }  -- Bottom Left Corner 
    }, "fan", "static")


function love.load()
  love.graphics.setDefaultFilter("nearest","nearest" , 16)
  local sprites = {"0.png", "1.png", "2.png", "3.png"}
  local texture = love.graphics.newArrayImage(sprites)
  mesh:setTexture(texture)
end           

function setLayer()
  local w
  for i = 1, 4 do 
    if  toggle == 1  then
      w = uv[i].w
    elseif toggle == -1 then
      w = 1
    end
    mesh:setVertexAttribute( i, 2, uv[i].u, uv[i].v, layer, w )
  end
end


function love.update(dt)
end

function love.draw()
  love.graphics.setShader(perspective)
  love.graphics.draw(mesh,400,150)
  love.graphics.setShader()
  
  love.graphics.print( "Press 1, 2, 3 or 4 to select the Layer\nPress P to toggle the perspective correct renering", 10, 10 )
  if  toggle == 1  then
    love.graphics.print( "Perspective Correction = ON", 10, 50 )
  elseif toggle == -1 then
    love.graphics.print( "Perspective Correction = OFF", 10, 50 )
  end
end


function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
     love.event.quit()
  elseif key == "1" then
    layer = 0
    setLayer()
  elseif key == "2" then
    layer = 1
    setLayer()
  elseif key == "3" then
    layer = 2
    setLayer()
  elseif key == "4" then
    layer = 3
    setLayer()
  elseif key == "p" then
    toggle = toggle * -1
    setLayer()
  end
end
