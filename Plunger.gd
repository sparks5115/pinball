extends AnimatableBody2D

@export var rest_y = position.y          # starting Y position
@export var max_pullback = 200    # max Y when pulled
@export var speed = 10000            # speed of plunger movement
@onready var ball = $"../Ball"

var pulling_back = false

func _on_Flipper_body_entered(body):
	if body.name == "Ball":
		body.apply_impulse(Vector2.ZERO, Vector2(0, -800))  # tune this

func _physics_process(delta):
	# Check input
	if Input.is_action_pressed("plunger_down"):
		pulling_back = true
	else:
		# Release the plunger
		if pulling_back:
			# Launch the ball by applying an impulse
			ball.set_axis_velocity(Vector2(0, -speed))  # tune strength
		pulling_back = false

	# Move plunger visually
	if pulling_back:
		position.y = min(position.y + speed * delta, max_pullback)
	else:
		position.y = max(position.y - speed * delta, rest_y)
