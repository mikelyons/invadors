--[[
    states.lua

    This file registers all the states that are available to the menu system
    WIP

    @TODO - scan the states directory and load each state with the appropriate loader
    @TODO - create a menu system for the states - uitest

]]

    -- try to get multithreading working
    loadStateFile('mts')
    loadStateFile('orbital')
    -- self:gotoState('mts')

    loadStateFolder('characterCreation')

  loadStateFile  ('pause')
  -- Various mini-games 
  loadStateFolder('uiTest')
  loadStateFolder('asciiGame')
  loadStateFolder('synth')
  loadStateFolder('prog2')
  loadStateFolder('generate')
  loadStateFolder('dialogue')
  loadStateFolder('computer')
  loadStateFolder('book')
  loadStateFile  ('bizzaro')
  loadStateFolder('prog2')
  loadStateFile  ('pro')
  loadStateFolder('kitchen')

  -- ingame UIs
  loadStateFolder('inventory')

  -- menu states
  loadStateFolder('menu')
  loadStateFolder('options')
  loadStateFolder('wireArt')
  loadMenuStateFile('newGame')
  loadStateFile  ('createWorld')
  loadMenuStateFile('loadSave')
  loadMenuStateFile('signin')
  loadStateFolder('infiniteRunner')
  loadStateFolder('editor')
  -- loadStateFolder('tiledZoom')
  loadStateFolder('face')
  loadStateFolder('quadtree')
  -- loadStateFolder('mic')
  -- loadStateFolder('template')
  -- self:gotoState('template')
  -- loadMenuStateFile('pressStart')
  -- self:gotoState('PressStart')

  -- local BOOT_TO_STATE = 'tiledZoom'
  -- local BOOT_TO_STATE = 'generate'
  -- local BOOT_TO_STATE = 'synth'
  -- local BOOT_TO_STATE = 'mic'
  if BOOT_TO_STATE ~= nil then
    self:gotoState(BOOT_TO_STATE or 'menu')
  else
    self:gotoState('menu')
  end




function Menu:keypressed(key, code)
  -- if key == ('1' or 'return') then self:pushState('signin') end
  -- if key == ('o') then self:pushState('mic') end
  -- if key == ('6' or 'h') then self:pushState('pro') end
  -- if key == ('3' or 'q') then self:pushState('space1') end
  -- if key == ('4' or 'w') then self:pushState('Earth2') end
  -- if key == ('5') then self:pushState('commando') end

  if key == ('b') then self:pushState('book') end
  -- if key == ('i') then self:pushState('infiniteRunner') end
  if key == ('i') then self:pushState('inventory') end
  if key == ('c') then self:pushState('face') end
  if key == ('e' or 'l') then self:pushState('dialogue') end
  if key == ('f') then self:pushState('editor') end
  if key == ('g') then self:gotoState('generate') end
  if key == ('p') then self:pushState('asciiGame') end
  if key == ('q') then self:pushState('quadtree') end
  if key == ('u') then self:gotoState('uiTest') end
  if key == ('t') then self:pushState('tiledZoom') end
  if key == ('w') then self:pushState('wireArt') end

  if key == ('1' or 'return') then self:pushState('computer') end
  if key == ('2' or 'space') then self:pushState('bizzaro') end
  if key == ('3' or 's') then self:pushState('synth') end
  if key == ('4' or 'm') then self:pushState('mts') end
  if key == ('5') then self:pushState('prog2') end
  if key == ('7') then self:pushState('orbital') end
  if key == ('8') then self:pushState('characterCreation') end
  if key == ('9') then self:pushState('kitchen') end


  if key == ('escape') then love.event.push('quit') end
end