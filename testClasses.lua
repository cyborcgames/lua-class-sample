local m = {}

-- Creating the Animal Class
local Animal = class: Animal{
	new = function(self, animalType, habitat, diet, isHungry)
		self.animalType = animalType
		self.habitat = habitat
		self.diet = diet
		self.isHungry = isHungry

		self:greet()

		if self.isHungry then
			print("I am hungry")
			self:searchForFood()
		end
	end,

	-- class specific variable ( stays the same for all instances of Animal )
	isAnimal = true,

	greet = function(self)
		print("Hi! I am a "..self.animalType..". I live in the "..self.habitat..".")
	end,

	searchForFood = function(self)
		print("Searching for food...")

		repeat
		 
		-- create a simple random mechanism to find 3 types of food
		local randNum = math.random(1,3)
		local foundFood, foundFoodType

		if randNum == 1 then
			foundFood = "sandwich"
			foundFoodType = "omnivore"
		elseif randNum == 2 then
			foundFood = "grass"
			foundFoodType = "herbivore"
		elseif randNum == 3 then
			foundFood = "rabbit"
			foundFoodType = "carnivore"
		end

		print("I found this strange looking "..foundFood)

		-- check if the animal can eat this
		if foundFoodType == self.diet or (self.diet == "omnivore") then
			print("Yum! It tastes delicious!")
			self.isHungry = false
		else
			print("I cannot eat that")
		end

		until not self.isHungry
	end,

	starve = function(self)
		self.isHungry = true
		print("I am feeling hungry")
		self:searchForFood()
	end,

	eat = function(self, food)
		print("Eating "..food)
		self.isHungry = false
	end
}

m.Animal = Animal

-- Creating the Pet Class
local Pet = class: Pet {
	new = function(self, petName, ownerName, address)
		self.name = petName
		self.owner = ownerName
		self.address = address
	end
}

m.Pet = Pet

local Dog = class: Dog(Animal, Pet) {
	new = function(self, animalType, habitat, diet, isHungry, petName, ownerName, address  )
		
		Animal.new(self, animalType, habitat, diet, isHungry)
		Pet.new(self, petName, ownerName, address)

	end

}

m.Dog = Dog

return m

