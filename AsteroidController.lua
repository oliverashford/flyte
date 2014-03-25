local AsteroidController = {}   

local Asteroid = require( "Asteroid" )

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function AsteroidController:new ( )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local asteroids = {}
   
    object = {
        eventObject = eventObject,
        asteroids = asteroids
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

function AsteroidController:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function AsteroidController:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function AsteroidController:update()
    
    for i, asteroid in ipairs(self.asteroids) do 
        -- move the buyllet position
        asteroid:update()
        
        -- destroy asteroids if they are off screen
        if ( asteroid.gfx.x  < -asteroid.gfx.width ) then
            asteroid.gfx:removeSelf()
            asteroid = nil
            table.remove( self.asteroids, i )
        end
    end
end

function AsteroidController:getAsteroids()
    return self.asteroids
end

function AsteroidController:spawn( _x, _y, _radius )
    print( "Spawning Asteroid" )
    
    local tempAsteroid = Asteroid:new( _x, _y, _radius )
    
    tempAsteroid:addEventListener( 'DESTROYED', self.destroyed )
    
    table.insert( self.asteroids, tempAsteroid )
end

function AsteroidController:destroyed( _event )
    
    print( "AsteroidController:destroyed( _event )" )
    
    print( _event )
    
end

return AsteroidController