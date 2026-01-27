--[[
  services.lua

  Service Locator pattern for managing global game services.
  Provides a centralized registry for core systems while maintaining
  backward compatibility with existing global variables.

  Usage:
    local Services = require('src/core/services')

    -- Register a service
    Services:register('renderer', myRenderer)

    -- Get a service
    local renderer = Services:get('renderer')

    -- Check if a service exists
    if Services:has('audio') then ... end
]]

local Services = {
  _services = {},
  _initialized = false,
}

--- Register a service with the locator
-- @param name string The service identifier
-- @param service any The service instance
-- @param exposeGlobal boolean (optional) If true, also sets a global variable (default: true for backward compat)
function Services:register(name, service, exposeGlobal)
  if exposeGlobal == nil then
    exposeGlobal = true -- Default to exposing globally for backward compatibility
  end

  self._services[name] = service

  -- Bridge for backward compatibility with existing code
  if exposeGlobal then
    _G[name] = service
  end

  if DEBUG_LOGGING_LOADING then
    print(string.format("[Services] Registered: %s", name))
  end
end

--- Get a service by name
-- @param name string The service identifier
-- @return any The service instance, or nil if not found
function Services:get(name)
  return self._services[name]
end

--- Check if a service is registered
-- @param name string The service identifier
-- @return boolean True if the service exists
function Services:has(name)
  return self._services[name] ~= nil
end

--- Unregister a service
-- @param name string The service identifier
-- @param removeGlobal boolean (optional) If true, also removes the global variable (default: true)
function Services:unregister(name, removeGlobal)
  if removeGlobal == nil then
    removeGlobal = true
  end

  self._services[name] = nil

  if removeGlobal then
    _G[name] = nil
  end
end

--- Get all registered service names
-- @return table Array of service names
function Services:list()
  local names = {}
  for name, _ in pairs(self._services) do
    table.insert(names, name)
  end
  return names
end

--- Initialize core services
-- Call this after all services are loaded to mark the system as ready
function Services:init()
  self._initialized = true
  if DEBUG_LOGGING_LOADING then
    print("[Services] Initialized with services: " .. table.concat(self:list(), ", "))
  end
end

--- Check if the service system is initialized
-- @return boolean True if initialized
function Services:isInitialized()
  return self._initialized
end

--- Register existing globals as services (for migration)
-- This helps during the transition period from globals to Services
function Services:registerExistingGlobals()
  local commonGlobals = {
    'renderer', 'gameloop', 'camera',
    'asm', 'tlm', 'obm',
  }

  for _, name in ipairs(commonGlobals) do
    if _G[name] and not self._services[name] then
      self._services[name] = _G[name]
      if DEBUG_LOGGING_LOADING then
        print(string.format("[Services] Migrated global to service: %s", name))
      end
    end
  end
end

return Services
