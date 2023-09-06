extends CharacterBody2D
class_name MCField
@onready var interact_area = $Interact
@onready var anim_player =$AnimationPlayer
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0


func _physics_process(_delta):
	# Add the gravity.
	
	if Game.main.can_interact():
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
		if direction:
			velocity = direction * SPEED
			anim_player.play("walk")
			interact_area.rotation = velocity.angle()
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		move_and_slide()
