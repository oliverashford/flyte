local GroundController = {}   

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function GroundController:new ( ... )
    
    local eventObject = display.newRect(0, 0, 0, 0)

    -- add
    local groundScreens = {}
    
     -- create the GroundScreen
    local GroundScreen = require( "GroundScreen" )
    
    -- add the two GroundScreens into table
    table.insert( groundScreens, GroundScreen:new( 10, 0 ) )
    table.insert( groundScreens, GroundScreen:new( 10, display.contentWidth ) )

    object = {
        eventObject = eventObject,
        groundScreens = groundScreens,
        startHeight = 10
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

function GroundController:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function GroundController:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function GroundController:update()
    -- loop through each groundScreen 
    for i, ground in ipairs(self.groundScreens) do 
        -- move the ground
        ground.gfx.x = ground.gfx.x - 5
        
        -- if its offscreen remove it
        if ground.gfx.x + ground.gfx.width < 0 then
            
            ground = nil
            
            table.remove( self.groundScreens, 1 )
            
            self:addNewGround()
            
        end
        
    end
end

function GroundController:getGroundScreens()
    return self.groundScreens
end

function GroundController:addNewGround()
    
    --print("addNewGround")
    
    -- create the GroundSCreen
    local GroundScreen = require( "GroundScreen" )
    
    local tempGroundScreen = GroundScreen:new( self.startHeight, display.contentWidth )
    
    -- add into table
    table.insert( self.groundScreens, tempGroundScreen )    

end

return GroundController