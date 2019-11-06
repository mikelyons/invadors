local ec = {}
function ec:new() 
  return {
  components    = {},
  component_ids = {},

  ID = id or 'entity',

  add_component  = function( self, id, component, args ) 
    component.init(self, args)
    self.components[id] = component
    table.insert(self.component_ids, id)
  end,
  tick = function( self) 
    for i = 1, #self.component_ids do
      self.components[self.component_ids[i]].tick(self)
    end

    self:update()
  end,
  draw = function( self) 
    for i = 1, #self.component_ids do
      self.components[self.component_ids[i]].draw(self)
    end

    self:render()
  end,
  update = function( self) end,
  render = function( self ) end,
  load = function(self) end,

  init = function(self) 
    gameloop:addLoop(self)
    renderer:addRenderer(self)

    self:load()
  end,
}
end
return ec