extends CanvasLayer

@onready var buttons = [
	$Options/Buttons/Resume, 
	$Options/Buttons/Restart, 
	$Options/Buttons/Setting, 
	$"Options/Buttons/Main Menu"
]

@onready var buttons_sprite = [
	$Options/Sprites/Resume, 
	$Options/Sprites/Restart, 
	$Options/Sprites/Setting, 
	$"Options/Sprites/Main Menu"
]


var P1_select_index = 0

func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	_menu_pausing_toggle(true)
	#await TransitionScreen.fade_out()
	
	#for button in $Options/Buttons.get_children():
		#button.visible = true
	match get_tree().current_scene.name:
		"MainMenu":
			#$Options/Buttons/Resume.visible = false
			$Options/Buttons/Restart.visible = false
			$"Options/Buttons/Main Menu".visible = false
			$Options/Buttons/Save.visible = false
		"Game":
			$Options/Buttons/Restart.visible = false
		"game_cafe":
			$Options/Buttons/Save.visible = false
		"game_office":
			$Options/Buttons/Save.visible = false
		_:
			print(get_tree().current_scene.name)

func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	#visible = !input
	if input == true:
		_show_select_update()
	else:
		visible = true
	

func _input(event):
	if PopupMessage.visible == false:
		if event is InputEventKey and event.pressed and not event.echo:
			handle_input_action(event)
		#elif event is InputEventJoypadButton and event.pressed:
			#handle_input_action(event)
		#elif event is InputEventJoypadMotion:
			#handle_motion_input_action()
	
func handle_input_action(event):
	if InputMap.event_is_action(event, "UI_control_pause"):
		print("unpause")
		visible = false
		_menu_pausing_toggle(true)
		await get_tree().process_frame
		get_tree().paused = false
	#AudioSoundBox2d._efxPLAY("select")
			#
	#if InputMap.event_is_action(event, "UI_control_down"):
		#P1_select_index = (P1_select_index + 1) % buttons.size()
	#if InputMap.event_is_action(event, "UI_control_up"):
		#P1_select_index = (P1_select_index - 1 + buttons.size()) % buttons.size()
			#
	#if InputMap.event_is_action(event, "UI_control_pause"):
		#
		#visible = false
		#_menu_pausing_toggle(true)
		#await get_tree().process_frame
		#get_tree().paused = false
			#
	#if InputMap.event_is_action(event, "UI_control_confirm"):
		#match P1_select_index:
			#0:
				#get_tree().paused = false
				#visible = false
				#_menu_pausing_toggle(true)
				#
			#1:
				#pass
				##get_tree().paused = false
				##
				##_menu_pausing_toggle(true)
				##await TransitionScreen.fade_in()
				##Global.loading_next_scene_path = get_tree().current_scene.scene_file_path
				##get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")
				#
			#2:
				#_menu_pausing_toggle(true)
				#$Options/Menus/Setting._menu_pausing_toggle(false)
			#3:
				##$"Options/Buttons/Main Menu".emit_signal("pressed")
				#pass
				##get_tree().paused = false
				##
				##_menu_pausing_toggle(true)
				##await TransitionScreen.fade_in()
				##Global.loading_next_scene_path = "res://scene/UI/Menus/MainMenu.tscn"
				##get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")
			#_:
				#print("Default case: Invalid selection")
				#
	#_show_select_update()
	
			
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



func _close_all_child_menu():
	for child in $Options/Menus.get_children():
		if child.has_method("_close_all_child_menu"):
			child._close_all_child_menu()
		child.visible = false
		if child.has_method("_menu_pausing_toggle"):
			child._menu_pausing_toggle(true)

#PRESS--------------
	

	
func _on_resume_pressed() -> void:
	_close_all_child_menu()
	get_tree().paused = false
	visible = false
	_menu_pausing_toggle(true)
	


func _on_restart_pressed() -> void:
	get_tree().paused = false
	
	_menu_pausing_toggle(true)
	await TransitionScreen.fade_in()
	Global.loading_next_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")

func _on_setting_pressed() -> void:
	_close_all_child_menu()
	#_menu_pausing_toggle(true)
	$Options/Menus/Setting_inDialogue._menu_pausing_toggle(false)
	
func _on_main_menu_pressed() -> void:
	
	PopupMessage.setup_popup_message("Are you sure you want to return to the main menu?\nThis will lose unsaved progress.", 2, ["No", "Yes"])
	var result: String = await PopupMessage._PopUp_Message_pressed_
	if result == "Yes":
		get_tree().paused = false
	
		_menu_pausing_toggle(true)
		await TransitionScreen.fade_in()
		Global.loading_next_scene_path = "res://scene/UI/Menus/MainMenu.tscn"
		get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")
	else:
		return
	
	


func _on_save_pressed() -> void:
	_close_all_child_menu()
	#_menu_pausing_toggle(true)
	$Options/Menus/SaveLoad_inDialogue.save_or_load_check = "save"
	$Options/Menus/SaveLoad_inDialogue._menu_pausing_toggle(false)


func _on_load_pressed() -> void:
	_close_all_child_menu()
	#_menu_pausing_toggle(true)
	$Options/Menus/SaveLoad_inDialogue.save_or_load_check = "load"
	$Options/Menus/SaveLoad_inDialogue._menu_pausing_toggle(false)
