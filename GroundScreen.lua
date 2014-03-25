local GroundScreen = {}   

local MIN_HEIGHT = 10
local MAX_HEIGHT = 50
local MIN_VERTEX = 3
local MAX_VERTEX = 10

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function GroundScreen:new ( _startHeight, _x )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local gfx = self:buildGround( _startHeight )
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

function GroundScreen:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function GroundScreen:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function GroundScreen:buildGround( _startHeight )
    
    -- how many extra vertices?
    local extraVertices = math.random( MIN_VERTEX, MAX_VERTEX)
    
    --print( "_startHeight: " .. _startHeight)
    --print( "extraVertices: " .. extraVertices)
    --print( "---------------------")
    
    -- calculate the separation of each new vertex
    local xSeparation = display.contentWidth  / extraVertices

    -- create table and add start point top left
    local vertices = {}
    self:addXY( vertices, 0, display.contentHeight - _startHeight)
    
    -- run through and create each new vertex
    for i=1, extraVertices - 1 do
        
        local newX = i * xSeparation
        
        local newY = display.contentHeight - math.random( MIN_HEIGHT, MAX_HEIGHT ) 
        
        self:addXY( vertices,  newX, newY)
        
    end
    
    -- add top right final
    self:addXY( vertices, display.contentWidth, display.contentHeight - _startHeight)
    
    -- add bottom right and bottom left vertices
    self:addXY( vertices, display.contentWidth, display.contentHeight)
    self:addXY( vertices, 0, display.contentHeight)
    
    local myPoly = display.newPolygon( 0, 0, vertices)
    myPoly.y = display.contentHeight - myPoly.height
    
    -- create boundin box for debugging
    local myRect = display.newRect( myPoly.contentBounds.xMin, myPoly.contentBounds.yMin, myPoly.contentBounds.xMax, myPoly.contentBounds.yMax )
    myRect.strokeWidth = 1
    myRect:setFillColor( 0, 0, 0,0 )
    myRect:setStrokeColor( 1, 0, 0, 1 )
    
    local myGroup = display.newGroup()
    
    myGroup:insert(myPoly)
    myGroup:insert(myRect)
    
    return myGroup
end

function GroundScreen:addXY( _table, _x, _y )
    table.insert( _table, _x )
    table.insert( _table, _y )
end

return GroundScreen