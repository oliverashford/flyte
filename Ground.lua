local Ground = {}   

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function Ground:new ( ... )
    
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
        groundScreens = groundScreens
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

function Ground:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function Ground:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function Ground:update()
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

function Ground:addNewGround()
    
    print("addNewGround")
    
    -- create the GroundSCreen
    local GroundScreen = require( "GroundScreen" )
    
    local tempGroundScreen = GroundScreen:new( 10, display.contentWidth )
    
    -- add into table
    table.insert( self.groundScreens, tempGroundScreen )    

end

return Ground