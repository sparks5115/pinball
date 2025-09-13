extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


@export var pressed_rotation: float = -30.0  # angle when pressed (degrees)
@export var rest_rotation: float = 20.0      # angle when at rest
@export var speed: float = 15.0              # how fast to rotate
@export var is_left: bool = false             # check this in inspector for left flipper

func _physics_process(delta):
	var target_angle = rest_rotation

	if is_left and Input.is_action_pressed("flipper_left"):
		target_angle = pressed_rotation
	elif not is_left and Input.is_action_pressed("flipper_right"):
		target_angle = pressed_rotation

	# Smoothly rotate toward target
	rotation = lerp_angle(rotation, deg_to_rad(target_angle), delta * speed)
