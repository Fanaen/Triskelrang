local Entity = require(fuccboi_path .. '/entities/Entity')
local PhysicsBody = require (fuccboi_path .. '/mixins/PhysicsBody')
local Solid = Entity:extend('Solid')
Solid:implement(PhysicsBody)

function Solid:new(area, x, y, settings)
    Solid.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)
end

function Solid:update(dt)
    self:physicsBodyUpdate(dt)
end

function Solid:draw()
    self:physicsBodyDraw()
end

function Solid:save()
    local x, y = self.body:getPosition()
    if self.shape_name == 'chain' then return {x = x, y = y, shape = 'chain', loop = true, body_type = 'static', vertices = self.chain_vertices}
    else return {x = x, y = y, w = self.w, h = self.h, body_type = 'static'} end
end

return Solid
