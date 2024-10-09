extends Polygon2D

var MAPHEIGHT = null
var MAPWIDTH = null

const MAXCITIES = 100

const citysizefrac = 1.7
const citysizecutoff = 100 #cannot be smaller than maxcities/citysize frac

const city_mindistance = 250.0
const city_distance_chaos = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screensize = DisplayServer.window_get_size()
	#MAPWIDTH = screensize[0]
	#MAPHEIGHT = screensize[1]
	# make blank map centered at 0,0
	# set max zoom to fit entire map, assuming screen height is limiting factor
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func startmap(height: float, width: float) -> void:
	var shape = PackedVector2Array([
		Vector2(-width/2,-height/2),
		Vector2(-width/2, height/2),
		Vector2( width/2, height/2),
		Vector2( width/2,-height/2)
	])
	# self.name = "world"
	self.set_polygon(shape)
	self.set_color(Color("WHITE"))
	
	MAPHEIGHT = height
	MAPWIDTH = width
	
func startcities(numcities: int):
	if numcities > MAXCITIES:
		push_error(str(numcities) + " is too many cities. Max cities: " + str(MAXCITIES))
	else:
		var citycsv = preload("res://data/cities.csv").records
		
		var large = MapUtils.randomsample(0,101,ceil(numcities/citysizefrac))
		var small = MapUtils.randomsample(102,citycsv.size()-1,numcities - ceil(numcities/citysizefrac))
		var citylocs = MapUtils.generate_chaotic_points(numcities,city_mindistance,Vector2(MAPWIDTH, MAPHEIGHT),city_distance_chaos)
		var tempidx = 0
		for i in large + small:
			#print(citylocs[tempidx] - Vector2(MAPWIDTH/2, MAPHEIGHT/2))
			var testcity = GameManager.create_city(citycsv[i]["city_ascii"],citylocs[tempidx] - Vector2(MAPWIDTH/2, MAPHEIGHT/2))
			add_child(testcity)
			tempidx+=1

# update zoom levels of all sprites so they are still visible
func updatezooms(newzoom: Vector2):
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is City:
			child.setscale(newzoom)
