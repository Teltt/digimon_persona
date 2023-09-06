extends Node2D
signal faded_out
@onready var evolution_bar = $"Evolution Bar"
@onready var icon_crest = $"Icon Crest"
@onready var name_label = $"Name"
@onready var rankup_label = $"Rank Up"
@onready var fill_timer = $"Fill Timer"
@onready var blink_timer = $"Blink Timer"
@onready var animation_player = $"AnimationPlayer"
@export var rank = 0
var displaying = false
var segments_displayed = 0
var play_timers = false
var top_blinking = false
var social_name = "Taichi Kamiya":
	set (value):
		name_label.text = "[center]"+value
		social_name = value
var awaiting = false
func set_social_name(value):
	social_name = value

func set_evobar_rank(value):
	rank = value
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in(p_rank,crest_name,character):
	rank = p_rank
	displaying = true
	social_name = character
	icon_crest.play(crest_name.to_lower())
	animation_player.play("FadeIn")
func fade_out():
	displaying = false
	rank = 0
	segments_displayed = 0
	play_timers = false
	animation_player.play('FadeOut')
	icon_crest.set_visible(false)
	name_label.set_visible(false)
	rankup_label.set_visible(false)
	awaiting = true
	await(animation_player.animation_finished)
	awaiting = false
	faded_out.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if awaiting:
		return
	name_label.text = "[center]"+social_name
	if play_timers:
		for seg in evolution_bar.get_child_count():
			if seg+1 < segments_displayed:
				evolution_bar.get_child(seg).set_visible(true)
			elif seg+1 == segments_displayed:
				evolution_bar.get_child(seg).set_visible( not top_blinking )
			else:
				evolution_bar.get_child(seg).set_visible(false)
			if fill_timer.is_stopped():
				fill_timer.start()
			if rank == segments_displayed:
				if blink_timer.is_stopped():
					blink_timer.start()
		if Input.is_action_just_pressed("ui_accept"):
			fade_out()
	else:
		segments_displayed = 0
	pass
func set_stuff_visible():
	icon_crest.set_visible(true)
	name_label.set_visible(true)
	rankup_label.set_visible(true)
func start_timers():
	play_timers = true
func stop_timers():
	play_timers = false
func _on_fill_timer_timeout():
	segments_displayed += 1
	segments_displayed = clamp(segments_displayed,0, rank+1)


func _on_blink_timer_timeout():
	top_blinking = not top_blinking
	
