local Asteroid = {}   

local MIN_RAD = 0
local MAX_RAD = 15
local MIN_VERTEX = 7
local MAX_VERTEX = 21
local MAX_ROTATION = 1

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Asteroid:new ( _x, _y, _radius )
    
    local eventObject = display.newRect(0, 0, 0, 0)
   
    local gfx = self:buildAsteroid( _radius )
    gfx.x = _x
    gfx.y = _y

    object = {
        eventObject = eventObject,
        gfx = gfx,
        speed = 5,
        rotation = math.random( -MAX_ROTATION, MAX_ROTATION)
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

--[]
function Asteroid:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Asteroid:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Asteroid:update()
    self.gfx.x = self.gfx.x - self.speed
    --self.gfx.rotation = self.gfx.rotation + self.rotation
end

function Asteroid:buildAsteroid( _radius )
    
    -- how many extra vertices?
    local extraVertices = math.random( MIN_VERTEX, MAX_VERTEX)
    
    -- create table and add start point top left
    local vertices = {}
    self:addXY( vertices, _radius + math.random( MIN_RAD, MAX_RAD ), 0)
    
    -- run through and create each new vertex
    for i=1, extraVertices - 1 do
        local currentAngle = i * 360 / extraVertices
        local adjustedRadius = _radius + math.random( MIN_RAD, MAX_RAD )
        local newX = math.cos( math.rad( currentAngle ) ) * adjustedRadius
        local newY = math.sin( math.rad( currentAngle ) ) * adjustedRadius
        
        self:addXY( vertices,  newX, newY)
    end
    
    local myPoly = display.newPolygon( 0, 0, vertices )
    
    return myPoly
end

function Asteroid:destroyed()
    
    local event = {
        name = "destroyed",
        target = self
    }
    self:dispatchEvent( event )
end

function Asteroid:addXY( _table, _x, _y )
    table.insert( _table, _x )
    table.insert( _table, _y )
end

return Asteroid