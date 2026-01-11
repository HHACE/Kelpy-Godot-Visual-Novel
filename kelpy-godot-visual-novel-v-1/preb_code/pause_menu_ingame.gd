extends CanvasLayer

var P1_select_index = 1

var canUseEscape = false



func handle_input_action(event):
	Musicbox._efx_select()
	if InputMap.event_is_action(event, "pause"):
		if canUseEscape == true:
			_pause_menu_off()

	if InputMap.event_is_action(event, "down"):
		if P1_select_index == 4:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	elif InputMap.event_is_action(event, "up"):
		if P1_select_index == 1:
			P1_select_index = 4
		else:
			P1_select_index -= 1 
			

	if InputMap.event_is_action(event, "confirm"):
		match P1_select_index:
			1:
				_pause_menu_pause_on()
				$Setting/Setting1.visible = true
				$Setting/Setting1._pause_menu_pause_off()
			2:
				_pause_menu_pause_on()
				for i in range(1):
					await get_tree().process_frame
				#_pause_menu_off()
				#get_tree().reload_current_scene()
				$"../Loading"._move_to_next_scene(get_tree().current_scene.scene_file_path)
			3:
				_pause_menu_pause_on()
				for i in range(1):
					await get_tree().process_frame
				#_pause_menu_off()
				#get_tree().change_scene_to_file("res://Scenes/CharacterSelect.tscn")
				$"../Loading"._move_to_next_scene("res://Scenes/MainMenu.tscn")
			4:
				_pause_menu_off()
			_:
				print("Default case: Invalid selection")
				
	_select_show()
	
			
func handle_motion_input_action():
	Musicbox._efx_select()
	
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if x < -0.5: # left
		pass
	elif x > 0.5: # right
		pass
	if y < -0.5: #up
		if P1_select_index == 1:
			P1_select_index = 4
		else:
			P1_select_index -= 1 
	elif y > 0.5: # down
		if P1_select_index == 4:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	_select_show()
func _input(event):
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():  # Check if it's a key event and the key is pressed
		#Musicbox._efx_select()
		#if event.physical_keycode == KEY_ESCAPE:
			#if canUseEscape == true:
				#_pause_menu_off()
#
		#if event.physical_keycode == KEY_DOWN or event.physical_keycode == KEY_S:
			#if P1_select_index == 4:
				#P1_select_index = 1 
			#else:
				#P1_select_index += 1 
				#
		#elif event.physical_keycode == KEY_UP or event.physical_keycode == KEY_W:
			#if P1_select_index == 1:
				#P1_select_index = 4
			#else:
				#P1_select_index -= 1 
				#
#
		#if event.physical_keycode == KEY_ENTER or event.physical_keycode == KEY_SPACE:
			#match P1_select_index:
				#1:
					#_pause_menu_pause_on()
					#$Setting/Setting1.visible = true
					#$Setting/Setting1._pause_menu_pause_off()
				#2:
					#_pause_menu_pause_on()
					#for i in range(1):
						#await get_tree().process_frame
					#_pause_menu_off()
					##get_tree().reload_current_scene()
					#$"../Loading"._move_to_next_scene(get_tree().current_scene.scene_file_path)
				#3:
					#_pause_menu_pause_on()
					#for i in range(1):
						#await get_tree().process_frame
					#_pause_menu_off()
					##get_tree().change_scene_to_file("res://Scenes/CharacterSelect.tscn")
					#$"../Loading"._move_to_next_scene("res://Scenes/MainMenu.tscn")
				#4:
					#_pause_menu_off()
				#_:
					#print("Default case: Invalid selection")
					#
		#_select_show()

	if event is InputEventKey and event.pressed and not event.echo:
		handle_input_action(event)
	elif event is InputEventJoypadButton and event.pressed:
		handle_input_action(event)
	elif event is InputEventJoypadMotion:
		handle_motion_input_action()


func _ready() -> void:
	_pause_menu_pause_on()
	$Setting/Setting.grab_focus()
	P1_select_index = 2
	
	_select_reset()
	
	
	


func _process(delta: float) -> void:
	pass

func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2(525, $Setting/Setting.position.y + 55) 
			$Setting/Setting.grab_focus()
		2:
			$Select/SelectIcon.position = Vector2(525, $exit/restart.position.y + 55) 
			$exit/restart.grab_focus()
		3:
			$Select/SelectIcon.position = Vector2(525, $exit/mainMenu.position.y + 55) 
			$exit/mainMenu.grab_focus()
		4:
			$Select/SelectIcon.position = Vector2(525, $exit/resume.position.y + 55) 
			$exit/resume.grab_focus()
		_:
			print("Default case: Invalid selection")



func _select_reset():
	P1_select_index = 1
	_select_show()
	

		

func _pause_menu_off():
	visible=false
	$".."._canUseFlags_true()
	get_tree().paused = false
	set_process_input(false)
	
	
func _pause_menu_on():
	_select_reset()
	get_tree().paused = true
	set_process_input(true)
	visible=true
	
	for i in range(1):
		await get_tree().process_frame
	canUseEscape= true


func _pause_menu_pause_on():
	set_process_input(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	_select_reset()
