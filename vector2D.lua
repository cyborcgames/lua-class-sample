----------------------------- Vector class ----------------------------------

local m = {}
local Vector

Vector = class: Vector{
    new = function(self,x,y)
        if type(x) == "table" and isinstance(x, Vector) then
            -- we are passed a vector ->
            local vect = x
            self.x = vect.x
            self.y = vect.y
        else
            self.x = x
            self.y = y
        end
    end,
    
    length = function(self)
        return math.sqrt((self.x*self.x) + (self.y*self.y) )
    end,
    
    copy = function(self)
        return Vector(self.x, self.y)
    end,
    
    normalize = function(self)
        local length = self:length()
        
        if length > 0.000001 then
            self.x = self.x/length
            self.y = self.y/length
        end
    end,
    
    normalizeVector = function(vector)
        
        local newVect = Vector(vector.x,vector.y)
        return newVect:normalize()
        
    end,
    
    truncate = function(self,maximum)
        if self:length() > maximum then
            self:normalize()
            self = self*maximum
        end
    end,
    
    -- overrides the print function
    _print = function(self)
        print("Vector x = "..self.x.." y = "..self.y)
    end,
    
    dot = function(self, vec)
        return self.x * vec.x + self.y * vec.y
    end,
    
    -- overrides the add function
    __add = function(vector1, vector2)
        local result = Vector(vector1)
        
        if type(vector2) == "table" then
            result.x = result.x + vector2.x
            result.y = result.y + vector2.y
        else
            result.x = result.x + vector2
            result.y = result.y + vector2
        end
        return result
    end,
    
    -- overrides the subtract function
    __sub = function(vector1, vector2)
        local result = Vector(vector1)
        
        if type(vector2) == "table" then
            result.x = result.x - vector2.x
            result.y = result.y - vector2.y
        else
            result.x = result.x - vector2
            result.y = result.y - vector2
        end
        return result
    end,
    
    -- overrides the multiplication function
    __mul = function(vector1, vector2)
        local result = Vector(vector1)
        
        if type(vector2) == "table" then
            result.x = result.x * vector2.x
            result.y = result.y * vector2.y
        else
            result.x = result.x * vector2
            result.y = result.y * vector2
        end
        
        return result
    end,
    
    -- overrides the divide function
    __div = function(vector1, vector2)
        local result = Vector(vector1)
        
        if type(vector2) == "table" then
            result.x = result.x / vector2.x
            result.y = result.y / vector2.y
        else
            result.x = result.x / vector2
            result.y = result.y / vector2
        end
        return result
    end,
    
}

m.Vector = Vector

return m

