extends Panel

@export var current_city: City = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CloseButton.pressed.connect(self.close_screen)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close_screen()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_city(city: City):
	current_city = city
	$VBox/CityName.text = current_city.cityname
	for res in city.citydata:
		$VBox/Info.text += res + ": " + str(city.citydata[res]) + "\n"

func close_screen():
	$VBox/Info.text = ""
	self.hide()
