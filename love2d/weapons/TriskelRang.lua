local RiskelRang = fg.Class('RiskelRang','Entity')
RiskelRang:implement(fg.PhysicsBody)

RiskelRang.enter = {'Solid'}

function RiskelRang:new(area, x, y, settings)
    RiskelRang.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)

end

function RiskelRang:update(dt)
    self:physicsBodyUpdate(dt)

end

function RiskelRang:draw()
    self:physicsBodyDraw()

end

function RiskelRang:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        local x1, y1, x2, y2 = contact:getPositions()
        local weapon_bottom = self.y + self.h/2 - 4
        if y1 > weapon_bottom then
              
        end
    end
end

return RiskelRang