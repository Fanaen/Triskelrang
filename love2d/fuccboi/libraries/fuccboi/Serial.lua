local Serial = {}
Serial.__index = Serial

local ser = require (fuccboi_path .. '/libraries/ser/ser')

function Serial.new()
    local self = {}
    self.serialize = ser
    return setmetatable(self, Serial)
end

function Serial:loadArea(filename, area, loading_order)
    local area_data = love.filesystem.load(filename)()
    if area then
        if loading_order then
            for _, group_name in ipairs(loading_order) do
                for _, object in ipairs(area_data) do
                    if group_name == object.class_name then
                        local settings = {}
                        for k, v in pairs(object) do settings[k] = v end
                        area:createEntity(object.class_name, object.x, object.y, settings)
                    end
                end
            end
        else
            for _, object in ipairs(area_data) do
                local settings = {}
                for k, v in pairs(object) do settings[k] = v end
                area:createEntity(object.class_name, object.x, object.y, settings)
            end
        end
    else return area_data end
end

function Serial:loadObject(filename, area)
    local object_data = love.filesystem.load(filename)()
    if area then 
        local settings = {}
        for k, v in pairs(object_data) do settings[k] = v end
        area:createEntity(object_data.class_name, object_data.x, object_data.y, settings)
    else return object_data end
end

function Serial:saveArea(filename, area, dropped_classes, return_area)
    local dropped_classes = dropped_classes or {}
    local saved_objects = {}
    for _, group in ipairs(area.groups) do
        if not area.fg.fn.contains(dropped_classes, group.name) then
            for _, object in ipairs(group:getEntities()) do
                if object.save and not area.fg.classes[object.class_name].dont_save then
                    local object_data = object:save()
                    object_data.class_name = object.class_name
                    table.insert(saved_objects, object_data)
                end
            end
        end
    end
    if return_area then return saved_objects end
    local area_string = self.serialize(saved_objects)
    if not love.filesystem.write(filename, area_string) then 
        error('Could not write ' .. filename .. ' while saving area ' .. area.name .. '#' .. area.id .. '.')
    end
end

function Serial:saveObject(filename, object)
    if object.save then
        local object_data = object:save()
        object_data.class_name = object.class_name
        local object_string = self.serialize(object_data)
        if not love.filesystem.write(filename, object_string) then 
            error('Could not write ' .. filename .. ' while saving object ' .. object.class_name .. '#' .. object.id .. '.')
        end
    end
end

return setmetatable({new = new}, {__call = function(_, ...) return Serial.new(...) end})
