extends CanvasLayer

@onready var anim = $AnimationPlayer

var is_transitioning = false

func _ready() -> void:
	visible = false

func fade_out():
	visible = true
	is_transitioning = true
	anim.play("fade_out")
	await anim.animation_finished
	is_transitioning = false
	#visible = false

func fade_in():
	visible = true
	is_transitioning = true
	anim.play("fade_in")
	await anim.animation_finished
	is_transitioning = false
	#visible = false
