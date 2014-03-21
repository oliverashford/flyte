local fps = require("fps")
local performance = fps.PerformanceOutput.new()

performance.group.x = 50
performance.group.y = 10
performance.alpha = 0.6


local speed = 10


display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )


--First, declare a local reference variable for the stage.
local stage = display.currentStage
 

-- add the moveing bg
local Ground = require( "Ground" )
local myGround = Ground:new()


-- add the ship
local Ship = require( "Ship" )
local myShip = Ship:new()
myShip.gfx.x = 100
myShip.gfx.y = display.contentCenterY


-- add the touch listener events
local function myTouchListener( event )

    if ( event.phase == "began" ) then
        --code executed when the button is touched
        print( "object touched = "..tostring(event.target) )  --'event.target' is the touched object
    elseif ( event.phase == "moved" ) then
        --code executed when the touch is moved over the object
        --print( "touch location in content coordinates = "..event.x..","..event.y )
        myShip:setAngle(event.y)
    elseif ( event.phase == "ended" ) then
        --code executed when the touch lifts off the object
        print( "touch ended on object "..tostring(event.target) )
    end
    
    return true  --prevents touch propagation to underlying objects
end

stage:addEventListener( "touch", myTouchListener )

function updateListener( _event )
    myGround:update( myShip:getSpeed() )
    myShip:update()
end

Runtime:addEventListener( "enterFrame", updateListener )
