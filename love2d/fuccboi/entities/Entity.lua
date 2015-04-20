local Class = require (fuccboi_path .. '/libraries/classic/classic')
local Entity = Class:extend('Entity') 

function Entity:new(area, x, y, settings)
    local settings = settings or {}
    self.dead = false
    self.area = area 
    self.fg = area.fg
    if settings.id then self.area.fg.getUID(settings.id) end
    self.id = settings.id or self.area.fg.getUID()
    self.pool_active = false
    self.x = x
    self.y = y
    if settings then
        for k, v in pairs(settings) do self[k] = v end
    end
end

return Entity
