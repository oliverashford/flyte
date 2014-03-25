local BulletController = {}   

local Bullet = require( "Bullet" )

local SPEED = 10

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function BulletController:new ( )
    
    local eventObject = display.newRect(0, 0, 0, 0)
    
    local bullets = {}
   
    object = {
        eventObject = eventObject,
        bullets = bullets
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

function BulletController:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function BulletController:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function BulletController:update()
    for i, bullet in ipairs(self.bullets) do 
        -- move the buyllet position
        bullet:update()
        
        -- destroy bullets if they are off screen
        if ( bullet.gfx.x > display.contentWidth or bullet.gfx.y < 0 or bullet.gfx.y > display.contentHeight ) then
            bullet.gfx:removeSelf()
            bullet = nil
            table.remove( self.bullets, i )
        end
    end
end

function BulletController:fire( _x, _y, _angle )
    local tempBullet = Bullet:new( _x, _y, _angle )
    table.insert( self.bullets, tempBullet )
end

function BulletController:getBullets()
    return self.bullets
end

function BulletController:removeBullet()
    
end

return BulletController