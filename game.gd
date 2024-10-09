extends Node2D

const MAPHEIGHT = 10000.0
const  MAPWIDTH = 10000.0

const NUMCITIES = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var map = $map
	map.startmap(MAPHEIGHT,MAPWIDTH)
	map.startcities(NUMCITIES)
	initcam()
	
	# window resize event
	get_tree().get_root().size_changed.connect(resize)
	# zoom in/out from camera
	$camera.connect("zoom_changed",zoom_change)
	# city info panel
	for mapnode in $map.get_children():
		if mapnode is City:
			mapnode.connect("city_focus", show_city_info)
		
	
	
	$GUI/CityInfo.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_city_info(citynode: City):
	var CityInfo = $GUI/CityInfo
	print("City: " + citynode.name)
	CityInfo.set_city(citynode)
	CityInfo.show()

func initcam() -> void:
	var screensize = DisplayServer.window_get_size()
	$camera.minzoom = screensize[1] / MAPHEIGHT 
	$camera.maxzoom = 20

# called on window resize
func resize():
	var screensize = DisplayServer.window_get_size()
	$camera.minzoom = min(screensize[0],screensize[1]) / MAPHEIGHT 
	
func zoom_change(newzoom: Vector2):
	var map = $map
	map.updatezooms(newzoom)
