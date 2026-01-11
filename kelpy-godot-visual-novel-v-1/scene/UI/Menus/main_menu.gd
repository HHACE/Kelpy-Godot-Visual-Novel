extends Node2D

@onready var buttons = [
	$Options/Buttons/Start,
	$Options/Buttons/Setting,
	$Options/Buttons/Credit,
	$Options/Buttons/Exit
]

@onready var buttons_sprite = [
	$Options/Sprites/Start,
	$Options/Sprites/Setting,
	$Options/Sprites/Credit,
	$Options/Sprites/Exit
]


var P1_select_index = 0

func _ready() -> void:
	#--------------Loading setting
	#$PauseMenu_InGame_Dialogue/Options/Menus/Setting_inDialogue/Options/Menus/Audio_inDialogue.load_volume()
	
	
	
	#---------------------
	
	##--------------center window
	#var screen_pos = DisplayServer.screen_get_position()
	#var screen_size = DisplayServer.screen_get_size()
#
	#DisplayServer.window_set_size(Vector2i(1920,1080)/1.25)
	## Get the window size including decorations
	#var window_size = get_window().get_size_with_decorations()
#
	## Calculate screen center
	#var screen_center = screen_pos + screen_size / 2
#
	## Set window position so it is centered
	#get_window().set_position(screen_center - window_size / 2)
	#
	##DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	##-----------------------------
	P1_select_index = 0
	_show_select_update()
	
	await TransitionScreen.fade_out()

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
				#_menu_pausing_toggle(true)
				##for new game
				#Global.stage_data["Characters"].clear()
				#Global.stage_data= {
					#"Characters": [],
					#"Dialogue" : {"name":"", "index":0},
					#"Variables" : {"cafe":0, "office":0},
					#"Scene" : "Dialogue"
				#}
				#print("called")
				#await TransitionScreen.fade_in()
				#Global.loading_next_scene_path = "res://scene/Game/Game.tscn"
#
				#get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")
				pass
				
			1:
				_menu_pausing_toggle(true)
				$Options/Menus/Setting._menu_pausing_toggle(false)
			2:
				_menu_pausing_toggle(true)
				$Options/Menus/Credit._menu_pausing_toggle(false)
			3:
				get_tree().quit()
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




#PRESS--------------
func _on_start_pressed() -> void:
	_menu_pausing_toggle(true)
	#for new game
	Global.stage_data["Characters"].clear()
	Global.stage_data= {
		"Characters": [],
		"Dialogue" : [{"name":"scene_day_1", "index":0}],
		"Dialogue_Log": [],
		"Variables" : {"cafe":0, "office":0},
		"Scene" : "Dialogue"
	}
	print("called")
	_buttons_disable(true)
	await TransitionScreen.fade_in()
	Global.loading_next_scene_path = "res://scene/Game/Game.tscn"
	
	get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")


func _on_load_pressed() -> void:
	get_tree().paused = true
	$PauseMenu_InGame_Dialogue._menu_pausing_toggle(false)
	#$"../../../../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(true)
	$"PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue".save_or_load_check = "load"
	$"PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue"._menu_pausing_toggle(false)

func _on_gallery_pressed() -> void:
	_menu_pausing_toggle(true)
	$Options/Menus/Gallery._menu_pausing_toggle(false)
	

func _on_setting_pressed() -> void:
	#_menu_pausing_toggle(true)
	#$Options/Menus/Setting._menu_pausing_toggle(false)
	
	get_tree().paused = true
	$"PauseMenu_InGame_Dialogue"._menu_pausing_toggle(false)
	$"PauseMenu_InGame_Dialogue/Options/Menus/Setting_inDialogue"._menu_pausing_toggle(false)
	

	
	
func _on_credit_pressed() -> void:
	_menu_pausing_toggle(true)
	$Options/Menus/Credit._menu_pausing_toggle(false)

func _on_exit_pressed() -> void:
	PopupMessage.setup_popup_message("Are you sure you want to quit?", 2, ["No", "Yes"])
	var result: String = await PopupMessage._PopUp_Message_pressed_
	if result == "Yes":
		get_tree().quit()
	else:
		return


func _buttons_disable(input: bool):
	for i in buttons:
		if i is Button:
			i.disabled = input
