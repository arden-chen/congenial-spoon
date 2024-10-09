extends Camera2D

# Zoom factor for zooming in and out
@export var zoom_speed: float = 0.1
# Zoom factor for zooming in and out
@export var minzoom: float = 0.1
# Zoom factor for zooming in and out
@export var maxzoom: float = 20.0
# Pan speed for moving the camera
@export var pan_speed: float = 100.0

signal zoom_changed(newzoom: Vector2)

# Store the initial mouse position
var mouse_start_position: Vector2

func _ready():
	self.position = Vector2(0,0)
	self.zoom = Vector2(1,1)
	# Ensure the camera is set to process input
	set_process_input(true)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		# Record the start position when mouse button is pressed
		mouse_start_position = event.position
		# zoom in
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and zoom[0] < maxzoom:
			zoom = zoom * (1.0 + zoom_speed)
			emit_signal("zoom_changed",zoom)
		
		# zoom out
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and zoom[0] > minzoom:
			zoom = zoom * (1.0 - zoom_speed)
			emit_signal("zoom_changed",zoom)
		
	if event is InputEventMouseMotion and event.button_mask & MOUSE_BUTTON_MASK_LEFT:
		# Pan the camera when dragging the mouse with the left button pressed
		var delta = event.position - mouse_start_position
		position -= delta / zoom  # Adjust the camera position based on mouse movement
		mouse_start_position = event.position  # Update the start position for the next frame
	
	if event is InputEventMouseButton and not event.pressed:
		# Reset mouse start position when the mouse button is released
		mouse_start_position = Vector2.ZERO
	
func _process(delta: float):
	# Optional: smooth movement or additional camera behavior can be added here
	pass
