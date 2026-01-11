extends Node2D

@onready var buttons = [
	
	$Options/Buttons/Back
]

@onready var buttons_sprite = [
	
	$Options/Sprites/Back
]


var P1_select_index = 0

func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	
	visible = false
	_menu_pausing_toggle(true)
	
	load_user_dialogue_setting()

func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
		_show_select_update()
		$Options/Buttons.visible = false
		$Options/SelectIcon.visible = false
		$Label.visible = false
	else:
		visible = true
		$Options/Buttons.visible = true
		$Options/SelectIcon.visible = true
		$Label.visible = true
		
		


func _close_all_child_menu():
	for child in $Options/Menus.get_children():
		child.visible = false
		child._menu_pausing_toggle(true)

func _input(event):
	if PopupMessage.visible == false:
		if event is InputEventKey and event.pressed and not event.echo:
			handle_input_action(event)
		elif event is InputEventJoypadButton and event.pressed:
			handle_input_action(event)
		elif event is InputEventJoypadMotion:
			handle_motion_input_action()
	
func handle_input_action(event):
	AudioSoundBox2d._efxPLAY("select")
			
	if InputMap.event_is_action(event, "UI_control_down"):
		P1_select_index = (P1_select_index + 1) % buttons.size()
	if InputMap.event_is_action(event, "UI_control_up"):
		P1_select_index = (P1_select_index - 1 + buttons.size()) % buttons.size()
			
	if InputMap.event_is_action(event, "UI_control_confirm"):
		match P1_select_index:
			0:
				_menu_pausing_toggle(true)
				$Options/Menus/Control._menu_pausing_toggle(false)
			1:
				_menu_pausing_toggle(true)
				$Options/Menus/Audio._menu_pausing_toggle(false)
			2:
				_menu_pausing_toggle(true)
				$Options/Menus/Graphic._menu_pausing_toggle(false)
			3:
				visible = false
				_menu_pausing_toggle(true)
				$"../../.."._menu_pausing_toggle(false)
			_:
				print("Default case: Invalid selection")
				
	_show_select_update()
	
			
func handle_motion_input_action():
	AudioSoundBox2d._efxPLAY("select")
	
	var x = Input.get_action_strength("UI_control_right") - Input.get_action_strength("UI_control_left")
	var y = Input.get_action_strength("UI_control_down") - Input.get_action_strength("UI_control_up")
	if x < -0.5: # left
		pass
	elif x > 0.5: #  right
		pass
	if y < -0.5: #down
		P1_select_index = (P1_select_index - 1 + buttons.size()) % buttons.size()

	elif y > 0.5: #up
		P1_select_index = (P1_select_index + 1) % buttons.size()
			
	_show_select_update()



func _show_select_update():
	#for buttons node
	buttons[P1_select_index].grab_focus()
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	#for selector sprite node
	var target_button = buttons[P1_select_index]
	var tween = create_tween()
	tween.tween_property(
		$Options/SelectIcon/SelectSprite, 
		"position", 
		Vector2(target_button.position.x-50, target_button.position.y+50) , 
		0.15 
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
	
#-------------------------save and load
func Save_user_dialogue_setting():
	var json = JSON.stringify(Global.user_dialogue_setting)
	var file = FileAccess.open("user://user_settings/dialogue_settings.json", FileAccess.WRITE)
	
	if FileAccess.open("user://user_settings/dialogue_settings.json", FileAccess.ModeFlags.WRITE_READ) != null:
		file.store_string(json)
		file.close()
		print("Dialogue seting saved")
	else:
		push_error(FileAccess.get_open_error())

func load_user_dialogue_setting():
	if FileAccess.file_exists("user://user_settings/dialogue_settings.json"):
		var file = FileAccess.open("user://user_settings/dialogue_settings.json", FileAccess.READ)
		var parse_result = JSON.parse_string(file.get_as_text())

		file.close()
		print(parse_result)
		if parse_result:
			for action in parse_result.keys():
				if action == "txt_speed":
					Global.user_dialogue_setting["txt_speed"] = parse_result[action]
				if action == "txt_size":
					Global.user_dialogue_setting["txt_size"] = parse_result[action]
				if action == "auto_speed":
					Global.user_dialogue_setting["auto_speed"] = parse_result[action]

	$Options/Buttons/TXT_Speed/ProgressBar.value = Global.user_dialogue_setting["txt_speed"]
	_on_progress_bar_txt_speed_drag_(Global.user_dialogue_setting["txt_speed"])
	$Options/Buttons/TXT_Size/ProgressBar.value = Global.user_dialogue_setting["txt_size"]
	_on_progress_bar_txt_size_drag_(Global.user_dialogue_setting["txt_size"])
	$Options/Buttons/Auto_Speed/ProgressBar.value = Global.user_dialogue_setting["auto_speed"]
	_on_progress_bar_auto_speed_drag_(Global.user_dialogue_setting["auto_speed"])
				
	
#PRESS--------------





func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)



func _on_progress_bar_txt_speed_drag_(value: float) -> void:
	# slow, normal, fast, instant
	# var cps = 50 * 1 # 1 - 4
	# 10 20 30 40 50 60 70 80 90 100
	
	print(value)
	if value == 70:
		$Options/Buttons/TXT_Speed/Display/Display.text = "Instant"
	elif value >= 60:
		$Options/Buttons/TXT_Speed/Display/Display.text = "Fast"
	elif value >= 40:
		$Options/Buttons/TXT_Speed/Display/Display.text = "Normal"
	elif value >= 20:
		$Options/Buttons/TXT_Speed/Display/Display.text = "Slow"
	else:
		$Options/Buttons/TXT_Speed/Display/Display.text = "Slow"
	

	Global.user_dialogue_setting["txt_speed"] = value
	Global.emit_signal("_Setting_Dialogue_Changed_")
	


func _on_progress_bar_txt_size_drag_(value: float) -> void:
	# small, normal, big, bigger
	# or 32, 37, 42, 47
	print($Options/Buttons/TXT_Size/Display/Display.get_theme_font_size("font_size"))
	$Options/Buttons/TXT_Size/Display/Display.add_theme_font_size_override("font_size", value)
	
	Global.user_dialogue_setting["txt_size"] = value
	Global.emit_signal("_Setting_Dialogue_Changed_")
	

func _on_progress_bar_auto_speed_drag_(value: float) -> void:
	# slow, normal, fast, instant
	# 5, 3, 2, 1 
	$Options/Buttons/Auto_Speed/Display/Display.text = str(int(value)) + "s"
	match value:
		0.0:
			$Options/Buttons/Auto_Speed/Display/Display.text = "Instant"
			
	Global.user_dialogue_setting["auto_speed"] = value
	Global.emit_signal("_Setting_Dialogue_Changed_")

func _on_progress_bar_x_drag_ended(value_changed: bool) -> void:
	Save_user_dialogue_setting()
