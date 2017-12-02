-------------------------------------------------------------------------------
-- Load the class plugin for the whole project
-- "class" now becomes a global keyword for creating new classes
-- To see how classes are created check testClasses.lua and testClasses2.lua
-------------------------------------------------------------------------------

require( "plugin.class" )

-------------------------------------------------------------------------------
-- EXAMPLE 1 - USING BASIC CLASSES
-------------------------------------------------------------------------------

-- require the file in which we created our classes
local testClasses = require("testClasses")

-- assign the classes to local variables
local Animal = testClasses.Animal
local Dog = testClasses.Dog

-- Create instances of the class Animal
local camel = Animal("camel", "desert", "herbivore", true)
local hawk = Animal("hawk", "mountain", "carnivore", false)

-- the class Dog uses multiple inheritance from the Animal and Pet classes
local dog = Dog("dog", "garden", "omnivore", false, 
                "Sparky", "Marc", "New York")
				
-- calling functions on the objects
hawk:starve()
-- notice that Dog doesn't have a method starve() in testClasses.lua 
-- this method was inherited from the Animal class
dog:starve()

-------------------------------------------------------------------------------
-- EXAMPLE 2 - USING CLASSES WITH KEY ARGUMENTS
-------------------------------------------------------------------------------

-- require the file in which we created our classes
local testClasses2 = require("testClasses2")

-- assign the classes to local variables
local GenericEnemy = testClasses2.GenericEnemy
local BossEnemy = testClasses2.BossEnemy

-- Different instances of the class GenericEnemy - using key arguments
local ninja = GenericEnemy{enemyType = "ninja", health = 5}
local archer = GenericEnemy{enemyType = "archer", health = 2}

-- the class Boss uses multiple inheritance from the GenericEnemy and RangeEnemy classes
local bigJoe = BossEnemy{enemyType = "boss", health = 200, projectileDamage = 75, attackRadius = 400,
                bossName = "Big Joe", spawnPoint = "Cosmos Bar", specialAttack = "Seismic Slam"}
				
-- calling functions on the objects
ninja:attack()
-- notice that BossEnemy doesn't have a method attack() in testClasses2.lua 
-- this method was inherited from the GenericEnemy class
bigJoe:attack()

-------------------------------------------------------------------------------
-- USEFUL FUNCTIONS
-------------------------------------------------------------------------------
			
-- You can print the objects and check in the console which class they belong to
print(camel, hawk)

-- isinstance(instance, classInfo)
-- checks if the object belongs to a certain class
if isinstance(dog, Animal) then
    print("dog is an instance of Animal")
end

if not isinstance(dog, GenericEnemy) then
    print("dog is not an instance of GenericEnemy")
end

-- issubclass(class, classInfo)
-- checks if a given class is a subclass of another class
if issubclass(Dog, Animal) then
    print("Class Dog is a subclass of class Animal")
end

-------------------------------------------------------------------------------
-- VECTOR EXAMPLES - overriding operators
-------------------------------------------------------------------------------

local Vector2D = require("vector2D")
local Vector = Vector2D.Vector

local myVec = Vector(2,3)
local myVec2 = Vector(4,2)

-- Overriding operators - you can multiply, add or subtract 2 vector objects
-- using overriden operators in Vector2D.lua

local myVec3 = myVec*myVec2
print(myVec3.x, myVec3.y)

local myVec4 = myVec + myVec2
print(myVec4.x, myVec4.y)

-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------