--[[
  asset_manifest.lua
  
  Central registry for all game assets
  This file tracks all assets used in the game for easier management
]]

local AssetManifest = {
  -- Image assets
  images = {
    -- UI and interface
    ui = {
      shroom = "assets/shroom.png",
      mushroom = "assets/mushroom.png",
      mouse = "assets/mouse.png",
      galaxy = "assets/galaxy.png",
      dark_forest = "assets/dark_forest.png",
      light_forest_tileset = "assets/light_forest_tileset_0.png",
      doom_tilesets = {
        uac1 = "assets/doom_rpg_maker_tileset_uac1_by_theprinceofmars-d7a0cni.png",
        uac3_medbay = "assets/doom_rpg_maker_xp_tileset_uac3_medbay_by_theprinceofmars-d7a0d9b.png",
        hell1 = "assets/doom_rpg_maker_xp_tileset_hell1_by_theprinceofmars-d7a0d0p.png"
      }
    },
    
    -- Character sprites
    characters = {
      char = "assets/char.png",
      cat1 = "assets/cat1.png",
      joe = "assets/Joe.png",
      -- Character subdirectories
      avatars = "assets/character/avatars/",
      knights = "assets/character/knights/",
      shooting = "assets/character/shooting/"
    },
    
    -- Fonts
    fonts = {
      tinyfont = "assets/tinyfont.png",
      tinyfont_large = "assets/tinyfont-large.png",
      outlinefont = "assets/outlinefont.png",
      font_ti83 = "assets/font-ti83-6x8.png",
      -- Font subdirectories
      amazdoom = "assets/fonts/amazdoom/",
      japanese3 = "assets/fonts/japanese3.png",
      less_perfect_dos = "assets/fonts/LessPerfectDOSVGA.ttf"
    },
    
    -- Maps and tilesets
    maps = {
      big_tileset = "assets/big-tileset.tmx",
      -- Map subdirectories
      bedroom = "assets/maps/bedroom/",
      earthmap = "assets/maps/earthmap/",
      generator = "assets/maps/generator/",
      infinite = "assets/maps/infinite/",
      ship = "assets/maps/ship/",
      test = "assets/maps/test/"
    },
    
    -- Items and objects
    items = {
      beer_broken_green = "assets/items/beerbrokengreen.png",
      beer_green_bottle = "assets/items/beergreenbottle.png",
      copper_key = "assets/objects/copper-key.png"
    },
    
    -- Effects and particles
    effects = {
      blood = "assets/blood/",
      melting_corpse = "assets/melting-corpse/",
      particles = "assets/particles/",
      scars = "assets/scars/"
    },
    
    -- Background and environment
    backgrounds = {
      space = "assets/space/",
      parallax = "assets/parallax/",
      city = "assets/city/",
      concept_art = "assets/concept art/"
    }
  },
  
  -- Audio assets
  audio = {
    music = {
      neutrino = "assets/music/miha mōyo - neutrino.mp3",
      credits = "assets/music/music_credits.txt"
    },
    sounds = "assets/sounds/"
  },
  
  -- Data files
  data = {
    -- Configuration and save data
    saves = "saves/",
    config = "config/"
  }
}

-- Asset loading functions
local AssetLoader = {}

function AssetLoader.loadImage(path)
  if love.filesystem.getInfo(path) then
    return love.graphics.newImage(path)
  else
    print("Warning: Image not found: " .. path)
    return nil
  end
end

function AssetLoader.loadAudio(path)
  if love.filesystem.getInfo(path) then
    return love.audio.newSource(path, "static")
  else
    print("Warning: Audio not found: " .. path)
    return nil
  end
end

function AssetLoader.loadFont(path, size)
  if love.filesystem.getInfo(path) then
    if path:match("%.ttf$") then
      return love.graphics.newFont(path, size or 12)
    else
      return love.graphics.newImageFont(love.graphics.newImage(path))
    end
  else
    print("Warning: Font not found: " .. path)
    return nil
  end
end

-- Preload commonly used assets
function AssetLoader.preloadAssets()
  local preloaded = {}
  
  -- Preload essential UI images
  preloaded.shroom = AssetLoader.loadImage(AssetManifest.images.ui.shroom)
  preloaded.mouse = AssetLoader.loadImage(AssetManifest.images.ui.mouse)
  
  -- Preload fonts
  preloaded.tinyfont = AssetLoader.loadFont(AssetManifest.images.fonts.tinyfont)
  preloaded.outlinefont = AssetLoader.loadFont(AssetManifest.images.fonts.outlinefont)
  
  return preloaded
end

-- Export the manifest and loader
return {
  manifest = AssetManifest,
  loader = AssetLoader
} 