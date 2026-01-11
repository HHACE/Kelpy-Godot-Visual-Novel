extends Node2D

#-------------------signal
func _ready() -> void:
	Global.connect("_Setting_Dialogue_Changed_", _ON_Setting_Dialogue_Changed_)
	
func _ON_Setting_Dialogue_Changed_():
	$RichTextLabel.add_theme_font_size_override("normal_font_size", Global.user_dialogue_setting["txt_size"])
	print("Changing Dialogue text")

#-----------------------
func transition_move_in():
	$RichTextLabel.visible = false
	$"../NameBox".visible = false
	var tween = get_tree().create_tween()
	#tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	$".".position = Vector2(0, 400.0)
	tween.parallel().tween_property($".", "position", Vector2(0.0, 0.0), 0.5)
	
	await get_tree().create_timer(0.5).timeout
	$RichTextLabel.visible = true
	$"../NameBox".visible = true

func transition_move_out():
	$RichTextLabel.visible = false
	$"../NameBox".visible = false
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property($".", "position", Vector2(0, 400.0), 0.5)


#-------------DialogueBox texts custome animation
@onready var text_box: RichTextLabel = $RichTextLabel

signal _Typing_anim_done_
var full_text := ""
var char_index := 0
var speed := 0.03
var typing_anim := false

func show_text(text: String): # characters per second
	full_text = text
	text_box.text = full_text
	text_box.visible_characters = 0
	
	if Global.user_dialogue_setting["txt_speed"] >= 70:
		text_box.visible_characters = -1
	else:
		$CPS.wait_time = 1.0 / Global.user_dialogue_setting["txt_speed"]
		typing_anim = true

		while text_box.visible_characters < text_box.get_total_character_count():
			#print($CPS.wait_time)
			$CPS.start()
			await $CPS.timeout
			text_box.visible_characters += 1
	typing_anim = false
	emit_signal("_Typing_anim_done_")
	
func skip_text():
	text_box.visible_characters = text_box.get_total_character_count()
	typing_anim = false
	emit_signal("_Typing_anim_done_")
