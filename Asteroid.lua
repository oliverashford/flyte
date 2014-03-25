local Asteroid = {}   

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Asteroid:new ( _x, _y, _radius )
    
    local eventObject = display.newRect(0, 0, 0, 0)
   
    local gfx = display.newCircle(_x, _y, _radius)

    object = {
        eventObject = eventObject,
        gfx = gfx,
        speed = 5
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

function Asteroid:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Asteroid:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Asteroid:update()
    self.gfx.x = self.gfx.x - self.speed
end

function Asteroid:destroyed()
    local event = {
        name = "DESTROYED", 
        target = self 
    }
    self:dispatchEvent( event )
end

return Asteroid