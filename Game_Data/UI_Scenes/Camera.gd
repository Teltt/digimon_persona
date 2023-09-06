extends CharacterBody2D

@onready var player_area = $Area2D
const SPEED = 300.0



func _physics_process(_delta):
	# Add the gravity.
	if is_instance_valid(Game.main.event):
		position = Game.main.event.get_node("Camera_Pos").position
	elif not is_instance_valid(Game.main.field):
		position = Vector2.ZERO +Vector2(576,324)
	else:
		if Game.main.mc.global_position.distance_to(player_area.global_position) > 50:
			var direction = -(player_area.global_position - Game.main.mc.global_position)
			velocity = direction *3.5
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED/2)
			velocity.y = move_toward(velocity.y, 0, SPEED/2)

		move_and_slide()
