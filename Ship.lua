local Ship = {}   

local MAX_ANGLE = 45

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Ship:new ( ... )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local gfx = display.newPolygon( 0, 0, { 0, 0, 30, 5, 0, 10 })
    gfx.anchorY = 0.5
    
    object = {
        eventObject = eventObject,
        gfx = gfx,
        speed = 5,
        angle = 0
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

function Ship:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Ship:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Ship:getSpeed(  )
    return speed
end

function Ship:setSpeed( _speed )
    self.speed = _speed
end

function Ship:setAngle( _angle )
    self.angle = _angle - display.contentCenterY
    self.angle = MAX_ANGLE * self.angle / display.contentCenterY
    
    self.gfx.rotation = self.angle 
end

function Ship:getAngle( _angle )
    return self.angle
end

function Ship:update()
    -- calculate the lift/fall
    self.gfx.y = self.gfx.y + math.tan( math.rad( self.gfx.rotation ) ) * self.speed
end

return Ship