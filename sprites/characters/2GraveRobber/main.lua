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
world = love.physics.newWorld( 0, 9.81, true )
graveRobber = {}
graveRobber.body = love.physics.newBody(world, playerx, playery, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
graveRobber.shape = love.physics.newRectangleShape(20, 20) --the ball's shape has a radius of 20
graveRobber.fixture = love.physics.newFixture(graveRobber.body, graveRobber.shape, 1) -- Attach fixture to body and give it a density of 1.
graveRobber.fixture:setRestitution(0.9) --let the ball bounce
function love.load()

	windowX, windowY = love.graphics.getDimensions();

	player = love.graphics.newImage("GraveRobber_idle.png")
	iddle = love.graphics.newImage("GraveRobber_idle.png")
	background = love.graphics.newImage("background.png")

	playerFrame = love.graphics.newQuad(0, 0, 48, 48, player:getDimensions())
	playerXScale = 1
	playerYScale = 1
	isMoving = false

	srunning = 0
	running = false

end

function love.update(dt)
	world:update(dt)

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
		
end

function love.draw()
	love.graphics.draw(player, 50, 50, 100, 100)-- body
	love.graphics.draw(background, windowX/2, windowY/2)

	love.graphics.draw(player, playerFrame, graveRobber.body:getX(), graveRobber.body:getY(), math.rad(angle), playerXScale, playerYScale, 16, 13)-- body
	-- love.graphics.rectangle( "line", graveRobber.body:getX(), graveRobber.body:getY(), 20, 20 )
end