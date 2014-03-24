local fps = require("fps")
local performance = fps.PerformanceOutput.new()

performance.group.x = 50
performance.group.y = 10
performance.alpha = 0.6

local bullets = {}


local speed = 10


display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )


--First, declare a local reference variable for the stage.
local stage = display.currentStage


local Bullet = require( "Bullet" )
 

-- add the moveing bg
local Ground = require( "Ground" )
local myGround = Ground:new()


-- add the ship
local Ship = require( "Ship" )
local myShip = Ship:new()
myShip.gfx.x = 100
myShip.gfx.y = display.contentCenterY

-- add fire button
local fireButton = display.newRect(0, 0, 100, 100)
fireButton.x = stage.contentWidth - fireButton.width
fireButton.y = stage.contentHeight - fireButton.height

local function fire()
    
    local tempBullet = Bullet:new( myShip.gfx.x, myShip.gfx.x, 0 )
    
    table.insert(bullets, tempBullet)
    
end

-- add the touch listener events
local function myFireListener( _event )
    if ( _event.phase == "began" ) then
        fire()    
    end
end


fireButton:addEventListener( "touch", myFireListener )


-- add the touch listener events
local function myTouchListener( _event )

    if ( _event.phase == "began" ) then
        --code executed when the button is touched
        print( "object touched = "..tostring(_event.target) )  --'event.target' is the touched object
    elseif ( _event.phase == "moved" ) then
        --code executed when the touch is moved over the object
        --print( "touch location in content coordinates = "..event.x..","..event.y )
        myShip:setAngle(_event.y)
    elseif ( _event.phase == "ended" ) then
        --code executed when the touch lifts off the object
        print( "touch ended on object "..tostring(_event.target) )
    end
    
    return true  --prevents touch propagation to underlying objects
end

stage:addEventListener( "touch", myTouchListener )


function updateListener( _event )
    myGround:update( myShip:getSpeed() )
    myShip:update()
    
    for i, bullet in ipairs(bullets) do 
        bullet:update()
    end
end

Runtime:addEventListener( "enterFrame", updateListener )

--[[

int pnpoly(int nvert, float *vertx, float *verty, float testx, float testy)
{
  int i, j, c = 0;
  for (i = 0, j = nvert-1; i < nvert; j = i++) {
    if ( ((verty[i]>testy) != (verty[j]>testy)) &&
     (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
       c = !c;
  }
  return c;
}


function pnpoly( _nvert, _vertx, _verty, _testx, _testy )
  int i, j, c = 0
  
  for (i = 0, j = nvert-1; i < nvert; j = i++) {
    if ( ((verty[i]>testy) != (verty[j]>testy)) && (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
       c = !c;
  }
  
  return c
end


function hasCollided( obj1, obj2 )
    
    if obj1 == nil then
        return false
    end
    
    if obj2 == nil then	
        return false	
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax	
    
    return (left or right) and (up or down)
end

]]--
