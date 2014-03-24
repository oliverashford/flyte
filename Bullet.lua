local Bullet = {}   

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Bullet:new ( _x, _y, _angle )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local gfx = display.newCircle(_x, _y, 2)
    gfx.x = _x
    
    object = {
        eventObject = eventObject,
        gfx = gfx
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
  
    
    --return newPoly
end

return Bullet