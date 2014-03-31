local StarfieldController = {}   

local layersSetup = {
    {
        speed = 0.6,
        alpha = 0.6
    },
    {
        speed = 0.4,
        alpha = 0.4
    },
    {
        speed = 0.3,
        alpha = 0.3
    }
}

-------------------------------------------------
-- CONSTRUCTOR
-------------------------------------------------

function StarfieldController:new ( ... )
    
    local eventObject = display.newRect(0, 0, 0, 0)

    -- add
    local starfields =  {}
    
     -- create the StarfieldScreen
    local StarfieldScreen = require( "Starfield" )
    
    
    
    -- add the two StarfieldScreens into table
    for i, layer in ipairs(layersSetup) do 
        table.insert( starfields, StarfieldScreen:new( 0, layer.speed, layer.alpha ) )
        table.insert( starfields, StarfieldScreen:new( display.contentWidth, layer.speed, layer.alpha ) )
    end
    
    
    
    
    object = {
        eventObject = eventObject,
        starfields = starfields
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

function StarfieldController:dispatchEvent( _event )
    self.eventObject:dispatchEvent( _event )
end

function StarfieldController:addEventListener( ... )
    self.eventObject:addEventListener( ... )
end

function StarfieldController:update()
    -- loop through each starfieldScreen 
    for i, starfield in ipairs(self.starfields) do 
        
        -- get this starfield's speed
        local speed = starfield:getSpeed()
            
        -- move the starfield
        starfield.gfx.x = starfield.gfx.x - 5 * speed
        
        -- if its offscreen remove it
        if starfield.gfx.x  < -display.contentWidth then
                        
            local alpha = starfield:getAlpha()
            
            starfield = nil
            
            table.remove( self.starfields, i )
            
            self:addNewStarfield( speed, alpha )
            
        end
        
    end
end

function StarfieldController:addNewStarfield( _speed, _alpha )

    -- create the StarfieldSCreen
    local StarfieldScreen = require( "Starfield" )
    
    local tempStarfieldScreen = StarfieldScreen:new( display.contentWidth, _speed, _alpha )
    
    -- add into table
    table.insert( self.starfields, tempStarfieldScreen )    

end

return StarfieldController