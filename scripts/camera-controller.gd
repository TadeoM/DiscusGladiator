extends Camera2D

var velocity : Vector2
@export var speed: float = 1.0
@export var zoomSpeed: float = 0.1

func _input(event): 
	if(event.is_action_pressed("camera_up")):
		velocity.y = -1 * speed
	elif(event.is_action_pressed("camera_down")):
		velocity.y = 1 * speed
	if(event.is_action_pressed("camera_right")):
		velocity.x = 1 * speed
	elif(event.is_action_pressed("camera_left")):
		velocity.x = -1 * speed
	
	if(event.is_action_released("camera_up")):
		velocity.y = 0
	elif(event.is_action_released("camera_down")):
		velocity.y = 0
	if(event.is_action_released("camera_right")):
		velocity.x = 0
	elif(event.is_action_released("camera_left")):
		velocity.x = 0
	
	if(event.is_action_pressed("camera_zoom_in")):
		zoom.x += zoomSpeed
		zoom.y += zoomSpeed
	elif(event.is_action_pressed("camera_zoom_out")):
		zoom.x -= zoomSpeed
		zoom.y -= zoomSpeed

func _physics_process(delta: float) -> void:
	position += velocity
