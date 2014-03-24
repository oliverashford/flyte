local Bullet = {}   

local SPEED = 10

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Bullet:new ( _x, _y, _angle )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local gfx = display.newCircle(_x, _y, 2)
    gfx.x = _x
    gfx.y = _y
    
    local dX = math.cos( math.rad( _angle ) ) * SPEED   
    local dY = math.sin( math.rad( _angle ) ) * SPEED  
    
    object = {
        eventObject = eventObject,
        gfx = gfx,
        dX = dX,
        dY = dY
    }

    setmetatable( object, self )
    self.__index = self
    return object
end

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------

-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function Bullet:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Bullet:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Bullet:update()
    self.gfx.x = self.gfx.x + self.dX
    self.gfx.y = self.gfx.y + self.dY
end

return Bullet