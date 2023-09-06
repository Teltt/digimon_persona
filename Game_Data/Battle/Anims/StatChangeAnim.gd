extends Polygon2D

@onready var parent = get_parent()
@onready var child = get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if self.visible and parent.visible and child.visible:
		self.set_visible(false)
		parent.set_visible(false)
		child.set_visible(false)
	elif self.visible and parent.visible and not child.visible:
		child.set_visible(true)
	elif not self.visible and  not parent.visible and not child.visible:
		parent.set_visible(true)
	elif not self.visible and parent.visible and not child.visible:
		self.set_visible(true)
	pass # Replace with function body.
