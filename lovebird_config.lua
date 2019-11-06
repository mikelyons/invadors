-- @TODO : separate dev libs
local _debug = false
if _debug == true then
  lovebird = require "lib/lovebird/lovebird"
  lovebird.allowhtml = true
end

if _debug == true then
  lovebird.update(av_dt)
end
