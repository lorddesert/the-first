local player --player 
local playerFrame --player frame
local playerx = 250
local playery = 250

local angle = 0
--Animation parametters
local fps = 8 --Frames Per Second
local a_t = 1 / fps -- animation timer
local frame = 0
local fn = 3 --frame numbers
local xoffset

local playerSpeed = 50 -- This is the player's speed. This value can be change based on your liking.
local runSpeed = 100

function love.load()
	player = love.graphics.newImage("SteamMan_idle.png")
	iddle = love.graphics.newImage("SteamMan_idle.png")
	playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions())
	playerXScale = 1
	playerYScale = 1
	isMoving = false

	srunning = 0
	running = false
end

function love.update(dt)

	--Player idle animation
	if dt > 0.035 then return end
	a_t = a_t - dt
	if a_t <= 0 then 
		a_t = 1 / fps
		frame = frame + 1
		if frame > fn then 
			frame = 0
		end
		xoffset = 48 * frame
		playerFrame:setViewport(xoffset, 0, 48, 48)
	end

	
		--Player Move
		
	function love.keyreleased(key)
		if key == "a" then
			isMoving = false
			fn = 3
			player = iddle
			playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions())

		elseif key == 'd' then
			isMoving = false
			fn = 3
			player = iddle
			playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions())
		end
	end

    function love.keypressed (key)
    	if key == 'lshift' and srunning == 0 then
    	    srunning = 1
    	    running = true
    	    playerSpeed = playerSpeed + runSpeed
    	elseif key == 'lshift' and srunning == 1 then 
    		srunning = 0
    		running = false
    		playerSpeed = playerSpeed - runSpeed
    	elseif key == ('space') then
		    fn = 5
		    player = love.graphics.newImage("SteamMan_jump.png")
		    playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions())
    	end
    end

	if love.keyboard.isDown('d') then          -- When the player presses and holds down the "D" button:
		playerx = playerx + (playerSpeed * dt)

		if isMoving == false then 
			fn = 5
			player = love.graphics.newImage("SteamMan_walk.png")
			playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions()) -- The player moves to the right.
			isMoving = true
		end

		if running == true then
			fn = 5
			player = love.graphics.newImage("SteamMan_run.png")
			isMoving = true
		else
			isMoving = true
			player = love.graphics.newImage("SteamMan_walk.png")
		end

		playerXScale = 1
		lastKeyPressed = 'd'

	elseif love.keyboard.isDown('a') then
		playerx = playerx - (playerSpeed * dt)

		if isMoving == false then 
			fn = 5
			player = love.graphics.newImage("SteamMan_walk.png")
			playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions()) -- The player moves to the right.
			isMoving = true
		end

		if running == true then
			isMoving = true
			fn = 5
			player = love.graphics.newImage("SteamMan_run.png")
		else
			isMoving = true
			player = love.graphics.newImage("SteamMan_walk.png")
		end

		playerXScale = -1
		lastKeyPressed = 'a'

	elseif love.keyboard.isDown('q') then
		love.event.quit()
	end
end

function love.draw()
	if running == true then 
		love.graphics.print('Running!', 0, 70)
	else
		love.graphics.print('Walking', 0, 70)
	end

	love.graphics.draw(player, playerFrame, playerx, playery, math.rad(angle), playerXScale, playerYScale, 16, 13)-- body
end