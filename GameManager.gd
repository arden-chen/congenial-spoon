class_name GameManager

const city_scene: PackedScene = preload("res://city.tscn")

static func create_city(name: String, loc: Vector2) -> City:
	
	var ls = LabelSettings.new()
	ls.font_color = Color("Black")
	ls.font_size = 100
	
	var new_city = city_scene.instantiate()
	new_city.name = name
	new_city.cityname = name
	new_city.loc = loc
	new_city.settings = ls
	
	
	return new_city
