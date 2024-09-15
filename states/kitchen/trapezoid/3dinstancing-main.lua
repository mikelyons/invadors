-- I've changed the size of the triangle to 1/8 so I don't need
-- to scale it down in the 3D shader
local vertices = {
	{0, 0,  0,0, 1.0,0.2,0.2,1.0},
	{1/8,0,  0,0, 0.2,1.0,0.2,1.0},
	{1/8,1/8, 0,0, 0.2,0.2,1.0,1.0},
}
 
local mesh = love.graphics.newMesh(vertices, "triangles", "static")

-- It's still named "instancepositions" but now it will contain
-- a 3D-Position instead of a 2D one and it will also contain an
-- additional attribute for rotation, which I added to demonstrate
-- that it is possible to have multiple per-instance attributes.
-- You will probably end up needing multiple attributes because
-- you want the faces of your cubes to have both position and orientation.
local instancepositions = {}
for y=-8,8 do
	for x = -8,8 do
		local pos = {
			-- Position. I added a random z coordinate and changed the scale
			x/8, y/8, math.random()*2-1,
			-- Random rotation
			math.random()*math.pi*2
		}
		table.insert(instancepositions, pos)
	end
end

-- The instancemesh must also know about the additional attribute.
-- Note that I changed "InstancePosition" to just "InstancePos",
-- to demonstrate that there isn't anything special about the names
-- of these attributes. You can give them almost any name you like.
local instancemesh = love.graphics.newMesh(
	{
		{"InstancePos", "float", 3},
		{"InstanceRot", "float", 1},
	},
	instancepositions, nil, "static"
)

-- Now we attach both attributes to the mesh
mesh:attachAttribute("InstancePos", instancemesh, "perinstance")
mesh:attachAttribute("InstanceRot", instancemesh, "perinstance")


local shader = love.graphics.newShader[[
// I want to make stuff move to emphasize the 3D-ish-ness of the thing,
// so I need time.
uniform float time;

attribute vec3 InstancePos;
attribute float InstanceRot;

// Projection matrix, probably not really relevant to your problem.
const mat4 proj = mat4(
	1., 0., 0., 0.,
	0., 1., 0., 0.,
	0., 0., 1., .5,
	0., 0., 0., 2.5
);

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
	// This rotation matrix handles the rotation of individual instances
	mat3 iRot = mat3(
		cos(InstanceRot), 0., sin(InstanceRot),
		0., 1., 0.,
		-sin(InstanceRot), 0., cos(InstanceRot)
	);
	
	
	// I use this rotation matrix to make all instances rotate together.
	// It's not really relevant to your problem, but I wanted to have
	// this in here so I can visually check if everything is where
	// it should be in 3D.
	mat3 rot = mat3(
		cos(time), 0., sin(time),
		0., 1., 0.,
		-sin(time), 0., cos(time)
	);
	
	// Rotate the individual instance on the spot.
	vertex_position.xyz = iRot*vertex_position.xyz+InstancePos;
	
	// Apply the large-scale rotation, too. You can ignore this.
	vertex_position.xyz = rot*vertex_position.xyz;
	
	// Apply the projection matrix to give it perspective.
	return proj*vertex_position;
}
]]
 
function love.draw()
	-- Add depth test, so triangles at the front don't get drawn in the
	-- background
	love.graphics.setDepthMode("lequal", true)
	
	love.graphics.setShader(shader)
	
	-- Send time to the shader. Will be used to rotate everything.
	shader:send("time", love.timer.getTime())
	
	local instancecount = #instancepositions
	love.graphics.drawInstanced(mesh, instancecount, 0, 0)
end
