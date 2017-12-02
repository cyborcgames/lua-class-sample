local m = {}

-- Creating the GenericEnemy Class
local GenericEnemy = class: GenericEnemy{

    --[[
        Required arguments: enemyType, health
    --]]

	new = function(self, kargs)
	 
		-- all arguments are put in a string separated by comma or space
		local ctorArgsStr  = "enemyType,health"

		-- check which of the given kargs correspond to the string of arguments ctorArgsStr
		local ctor_kargs = parse_ka(kargs, {required = ctorArgsStr})

		-- form the constructor args
		for k,_ in ctorArgsStr:gmatch('%w+') do
			local v = ctor_kargs[k]
			rawset(self, k, v)                 -- a nil arg will not be inserted
		end
                
	end,
     
	-- class specific variable ( stays the same for all instances of GenericEnemy )
	isEnemy = true,

	whoIs = function(self)
		print("GenericEnemy of type: "..self.enemyType.." with health: "..self.health..".")
	end,

	attack = function(self)
		print("ARGHHHH! I attack!")
	end
}

m.GenericEnemy = GenericEnemy

-- Creating the RangeEnemy Class
local RangeEnemy = class: RangeEnemy {

    --[[
        Required arguments:  projectileDamage = 75, attackRadius = 400
    --]]

	new = function(self, kargs)
	 
		local ctorArgsStr  = "projectileDamage,attackRadius"

		-- assert the required arguments for the constructor args
		local ctor_kargs = parse_ka(kargs, {required = ctorArgsStr})

		-- form the constructor args
		for k,_ in ctorArgsStr:gmatch('%w+') do
			local v = ctor_kargs[k]
			rawset(self, k, v)                 -- a nil arg will not be inserted
		end
	 
	end
}

m.RangeEnemy = RangeEnemy

local BossEnemy = class: BossEnemy(GenericEnemy, RangeEnemy) {
    
    new = function(self, kargs)
                
		-- first inherit all variables and methods from the base classes
		GenericEnemy.new(self, kargs)
		RangeEnemy.new(self, kargs)
                
		-- additional unique class variables
		-- ctorArgs[1] contains required variables, ctorArgs[2] - only optional
		local ctorArgs = {}
		ctorArgs[1] = "bossName spawnPoint"
		ctorArgs[2] = "specialAttack specialDefense"
		 
		-- assert the required arguments for the constructor args
		local ctor_kargs = parse_ka(kargs, {required = ctorArgs[1], optional = ctorArgs[2]})
		
		-- insert all the required/optional arguments in self
		for i=1, #ctorArgs do
			for k,_ in ctorArgs[i]:gmatch('%w+') do
				local v = ctor_kargs[k]
				rawset(self, k, v)                 -- a nil arg will not be inserted
			end
		end
                
		-- you can call functions from the constructor, as well
		self:whoIs()
	
    end,
	
    whoIs = function(self)
		print("Created boss "..self.bossName.." with health: "..self.health..". Spawn point: "..self.spawnPoint)
		print("Special attack: "..(self.specialAttack or "none"))
    end,
}

m.BossEnemy = BossEnemy

return m



