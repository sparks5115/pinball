extends AnimatableBody2D

@export var rest_y = position.y          # starting Y position
@export var max_pullback = rest_y + 200    # max Y when pulled
@export var speed = 6000            # speed of plunger movement


var pulling_back = false

func _physics_process(delta):
	# Check input
	if Input.is_action_pressed("plunger_down"):
		pulling_back = true
	else:
		# Release the plunger
#		if pulling_back:
			# Launch the ball by applying an impulse
#			ball.set_axis_velocity(Vector2(0, -speed))  # tune strength
		pulling_back = false

	# Move plunger visually
	if pulling_back:
		position.y = min(position.y + speed * delta, max_pullback)
	else:
		position.y = max(position.y - speed * delta, rest_y)
