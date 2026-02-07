extends CharacterBody3D

@export var speed = 14.0
@export var fall_acceleration = 75.0
@onready var camera_mount = $"../Camera pivot"
var player_healt
var player_maxhealt = GlobalPlayerStats.player_max_health
var sensitivity = 0.02

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = $"../Camera pivot".global_rotation

	if Input.is_action_pressed("move_right_p1"):
		direction.x += 1
	if Input.is_action_pressed("move_left_p1"):
		direction.x -= 1
	if Input.is_action_pressed("move_back_p1"):
		direction.z += 1
	if Input.is_action_pressed("forward_p1"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$".".basis = Basis.looking_at(direction)

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta

	velocity = target_velocity
	move_and_slide()
	
func _process(delta):
	$"../Camera pivot".global_position = $".".global_position
	var joystick_input = Input.get_vector("camera_left_p1", "camera_right_p1", "camera_up_p1", "camera_down_p1")
	if joystick_input.length() > 0.1:  # Deadzone
		camera_mount.rotation.y -= joystick_input.x * sensitivity
		camera_mount.rotation.x -= joystick_input.y * sensitivity
		camera_mount.rotation.x = clamp(camera_mount.rotation.x, -PI/2, PI/2)
























func _ready() -> void:
	player_healt = player_maxhealt


#func _process(delta: float) -> void:
#
#func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("forward_p1"):
		#
		##apply_central_force($".".transform * Vector3.FORWARD * GlobalPlayerStats.player_movement_speed * delta)
		#
	#if Input.is_action_pressed("move_back_p1"):
		##apply_central_force($".".transform* Vector3.BACK * GlobalPlayerStats.player_movement_speed * delta)
