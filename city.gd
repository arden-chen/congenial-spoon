class_name City

extends Node2D

@export var cityname: String = ""
@export var loc: Vector2 = Vector2(0,0)
@export var citydata: Dictionary = {
	"wood" = 1000
}

var settings = null

signal city_focus(city: City)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = loc
	var cb = $CityButton
	cb.pressed.connect(self.button_pressed)
	
	var label = $CityLabel
	label.text = cityname
	label.set_label_settings(settings)
	var testsize = label.get_minimum_size()
	label.position = Vector2(-testsize[0]/2 + cb.get_size()[0]/2,-150)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func button_pressed():
	emit_signal("city_focus",self)
	
func setscale(sc: Vector2):
	$CityButton.scale = Vector2(1/sc[0] ** 0.4,1/sc[1] ** 0.4)
	#print(self.scale)
