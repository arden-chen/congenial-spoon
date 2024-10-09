extends Node


class_name MapUtils

# coords as array of floats, [lat, long]
static func geo_to_grid(coords: Array):
	var screensize = DisplayServer.window_get_size()
	var x =  ((screensize[0]/360.0) * (coords[0]))
	var y =  ((screensize[1]/180.0) * (-coords[1]))
	var result = Vector2(x,y)
	#print(str(coords) + "-->" + str(result))
	return result

# Vector2 as point, array of two endpoints of line
static func perpendicularDistance(pt: Vector2, line: Array):
	var dist = line[0].distance_to(line[1])
	
	var x1 = line[0][0]
	var x2 = line[1][0]
	var y1 = line[0][1]
	var y2 = line[1][1]
	
	var num = abs((y2-y1)*pt[0] - (x2-x1)*pt[1] + x2*y1 -y2*x1)
	return num / dist

static func randomsample(start: int, end: int, numsamples: int):
	var nums = range(start,end+1)
	var result = []
	for i in range(numsamples):
		result.append(nums.pop_at(randi_range(0,nums.size()-1)))
	return result

# Function to generate points with minimum distance but with chaotic distribution
static func generate_chaotic_points(num_points: int, min_distance: float, area_size: Vector2, chaos_factor: float) -> Array:
	var points = []

	while points.size() < num_points:
		# Generate a random point within the given area
		var new_point = Vector2(randf() * area_size.x, randf() * area_size.y)

		# Check if the new point is at least `min_distance` away from all other points, adjusted by the chaos factor
		var valid = true
		for point in points:
			var random_factor = min_distance + randf() * chaos_factor  # Introduce randomness into the distance check
			if new_point.distance_to(point) < random_factor:
				valid = false
				break

		# If the point is valid, add it to the list
		if valid:
			points.append(new_point)

	return points
