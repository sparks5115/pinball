extends AnimatableBody2D

@export var rest_y: float
@export var max_pullback: float
@export var speed: float = 2000.0

var pulling_back := false

func _ready() -> void:
	# Save initial position if not set in the inspector
	if rest_y == 0.0:
		rest_y = position.y
	if max_pullback == 0.0:
		max_pullback = rest_y + 200

func _physics_process(delta: float) -> void:
	var motion := Vector2.ZERO

	# Input check
	if Input.is_action_pressed("plunger_down"):
		pulling_back = true
	else:
		pulling_back = false

	# When pulling back → move down
	if pulling_back and position.y < max_pullback:
		motion.y = speed * delta

	# When released → move up
	elif not pulling_back and position.y > rest_y:
		motion.y = -speed * delta

	# Apply motion through physics
	if motion != Vector2.ZERO:
		var collision = move_and_collide(motion)
		if collision:
			if motion.y < 0 and collision.get_collider() is RigidBody2D:
				var ball := collision.get_collider() as RigidBody2D
				ball.apply_impulse(Vector2(0, -speed * 0.05))  # tune multiplier
