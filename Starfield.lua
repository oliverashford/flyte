local Starfield = {}   

local STAR_COUNT = 100

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Starfield:new ( _x, _speed, _alpha )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local gfx = self:buildStars()
    gfx.alpha = _alpha
    gfx.x = _x
    
    object = {
        eventObject = eventObject,
        gfx = gfx,
        speed = _speed
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

function Starfield:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Starfield:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Starfield:getAlpha()
    return self.gfx.alpha
end

function Starfield:getSpeed()
    return self.speed
end

function Starfield:buildStars()
    
    local myGroup = display.newGroup()
    
    -- run through and create each new vertex
    for i=1, STAR_COUNT do
        
        local tempDot = display.newCircle( math.random( 0, display.contentWidth ), math.random( 0, display.contentHeight ), 1)
        myGroup:insert(tempDot)
    end
    
    return myGroup
end

return Starfield