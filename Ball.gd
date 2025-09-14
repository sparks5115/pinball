extends RigidBody2D

@export var respawn_position: Vector2

func _ready():
	# Store initial position if not manually set
	if respawn_position == Vector2.ZERO:
		respawn_position = global_position

func respawn():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	sleeping = true
	global_position = respawn_position
	sleeping = false
