local GroundScreen = {}   

local MIN_HEIGHT = 10
local MAX_HEIGHT = 100
local MIN_VERTEX = 0
local MAX_VERTEX = 5

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
    -- create table and add start point top left
    local vertices = {}
    self:addXY( vertices, 0, display.contentHeight - _startHeight)
    
    
    -- add terrain vertices
    self:addXY( vertices, display.contentWidth / 3, display.contentHeight - 40)
    self:addXY( vertices, display.contentWidth / 2, display.contentHeight - 25)
    self:addXY( vertices, display.contentWidth, display.contentHeight - _startHeight)
    
    

    
    -- add bottom right and bottom left vertices
    self:addXY( vertices, display.contentWidth, display.contentHeight)
    self:addXY( vertices, 0, display.contentHeight)
    
    local myPoly = display.newPolygon( 0, 0, vertices)
    myPoly.y = display.contentHeight - myPoly.height
    
    -- create boundin box
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