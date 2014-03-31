-- add the fps and memory readout
local fps = require("fps")
local performance = fps.PerformanceOutput.new()
performance.group.x = 50
performance.group.y = 10
performance.alpha = 0.6

-- settings
display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

--First, declare a local reference variable for the stage.
local stage = display.currentStage

local speed = 10 

local MIN_ASTEROID_WAIT = 1000
local MAX_ASTEROID_WAIT = 5000

-- add the moveing bg
local GroundController = require( "GroundController" )
local myGroundController = GroundController:new()

-- add the moveing bg
local BulletController = require( "BulletController" )
local myBulletController = BulletController:new()

-- add the asteroid bg
local AsteroidController = require( "AsteroidController" )
local myAsteroidController = AsteroidController:new()

-- add the ship
local Ship = require( "Ship" )
local myShip = Ship:new()
myShip.gfx.x = 100
myShip.gfx.y = display.contentCenterY

-- add fire button
local fireButton = display.newRect(0, 0, 100, 100)
fireButton.x = stage.contentWidth - fireButton.width
fireButton.y = stage.contentHeight - fireButton.height
fireButton.alpha = 0.6

-- add the fir button listener 
local function myFireButtonListener( _event )
    if ( _event.phase == "began" ) then
        myBulletController:fire( myShip.gfx.x, myShip.gfx.y, myShip:getAngle() )    
    end
end

-- add the touch listener
local function myStageTouchListener( _event )
    if ( _event.phase == "began" ) then
        --code executed when the button is touched
        --print( "object touched = "..tostring(_event.target) )  --'event.target' is the touched object
    elseif ( _event.phase == "moved" ) then
        --code executed when the touch is moved over the object
        --print( "touch location in content coordinates = "..event.x..","..event.y )
        myShip:setAngle(_event.y)
    elseif ( _event.phase == "ended" ) then
        --code executed when the touch lifts off the object
        --print( "touch ended on object "..tostring(_event.target) )
    end
    
    return true  --prevents touch propagation to underlying objects
end

-- add on
function myEnterFrameListener( _event )
    
    myGroundController:update( myShip:getSpeed() )
    
    myShip:update()
    
    myBulletController:update()
    
    myAsteroidController:update()
    
    -- test for ship ground collision
    for i, groundScreen in ipairs( myGroundController:getGroundScreens() ) do
        
        if hasCollidedBoundingBox( groundScreen.gfx, myShip.gfx ) then
            gameOver()
        end
        
    end
    
    -- test for ship asteroid collision
    for i, asteroid in ipairs( myAsteroidController:getAsteroids() ) do
        if hasCollidedBoundingBox( asteroid.gfx, myShip.gfx ) then      
            gameOver()
        end
    end
    
    -- test for bullet asteroid collision
    for i, bullet in ipairs( myBulletController:getBullets() ) do  
        
        for j, asteroid in ipairs( myAsteroidController:getAsteroids() ) do
            
            if hasCollidedBoundingBox( bullet.gfx, asteroid.gfx ) then
                asteroid:destroyed()
            end
        end
    end
    
end

-- launch an asteroid
local function myAsteroidListener( _event )
    
    local tempRadius = math.random( 20, 30 )
    
    myAsteroidController:spawn( display.contentWidth + tempRadius, 100, tempRadius)
    
    startAsteroidCountdown()
end



fireButton:addEventListener( "touch", myFireButtonListener )

stage:addEventListener( "touch", myStageTouchListener )

Runtime:addEventListener( "enterFrame", myEnterFrameListener )

function startAsteroidCountdown()
    local countdown = math.random( MIN_ASTEROID_WAIT, MAX_ASTEROID_WAIT )
    timer.performWithDelay( countdown, myAsteroidListener, 1 )
end

startAsteroidCountdown()

function hasCollidedBoundingBox( obj1, obj2 )
   if ( obj1 == nil ) then  --make sure the first object exists
      return false
   end
   if ( obj2 == nil ) then  --make sure the other object exists
      return false
   end

   local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
   local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
   local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
   local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

   return (left or right) and (up or down)
end

function gameOver()
    Runtime:removeEventListener( "enterFrame", myEnterFrameListener )
    
    display.newText( "GAME OVER", display.contentCenterX, display.contentCenterY, display.contentWidth / 2, display.contentHeight / 2, "courier", 40)
end

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

]]--