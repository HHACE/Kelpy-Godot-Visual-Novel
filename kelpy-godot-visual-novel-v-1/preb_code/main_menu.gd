extends Node2D

var P1_select_index = 1

func handle_input_action(event):
	Musicbox._efx_select()
	if InputMap.event_is_action(event, "down"):
		if P1_select_index == 5:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	elif InputMap.event_is_action(event, "up"):
		if P1_select_index == 1:
			P1_select_index = 5
		else:
			P1_select_index -= 1 
			
			
	if InputMap.event_is_action(event, "confirm"):
		match P1_select_index:
			1:
				#get_tree().change_scene_to_file("res://Scenes/CharacterSelect.tscn")
				_pause_menu_pause_on()
				$Loading._move_to_next_scene("res://Scenes/CharacterSelect.tscn")
			2:
				_pause_menu_pause_on()
				$Loading._move_to_next_scene("res://Scenes/StageSelect.tscn")
			3:
				$Gallery/Gallery1.visible = true
				$Gallery/Gallery1._pause_menu_pause_off()
				_pause_menu_pause_on()
			4:
				$Setting/Setting1.visible = true
				$Setting/Setting1._pause_menu_pause_off()
				_pause_menu_pause_on()
			5:
				get_tree().quit()
			_:
				print("Default case: Invalid selection")
				
	_select_show()
	
			
func handle_motion_input_action():
	Musicbox._efx_select()
	
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if x < -0.5:
		pass
	elif x > 0.5:
		pass
	if y < -0.5:
		if P1_select_index == 1:
			P1_select_index = 5
		else:
			P1_select_index -= 1 
	elif y > 0.5:
		if P1_select_index == 5:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	_select_show()
		
func _input(event):
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():  # Check if it's a key event and the key is pressed
		#Musicbox._efx_select()
#
		#if event.physical_keycode == KEY_DOWN or event.physical_keycode == KEY_S:
			#if P1_select_index == 5:
				#P1_select_index = 1 
			#else:
				#P1_select_index += 1 
				#
		#elif event.physical_keycode == KEY_UP or event.physical_keycode == KEY_W:
			#if P1_select_index == 1:
				#P1_select_index = 5
			#else:
				#P1_select_index -= 1 
				#
				#
		#if event.physical_keycode == KEY_ENTER or event.physical_keycode == KEY_SPACE:
			#match P1_select_index:
				#1:
					##get_tree().change_scene_to_file("res://Scenes/CharacterSelect.tscn")
					#_pause_menu_pause_on()
					#$Loading._move_to_next_scene("res://Scenes/CharacterSelect.tscn")
				#2:
					#_pause_menu_pause_on()
					#$Loading._move_to_next_scene("res://Scenes/StageSelect.tscn")
				#3:
					#$Gallery/Gallery1.visible = true
					#$Gallery/Gallery1._pause_menu_pause_off()
					#_pause_menu_pause_on()
				#4:
					#$Setting/Setting1.visible = true
					#$Setting/Setting1._pause_menu_pause_off()
					#_pause_menu_pause_on()
				#5:
					#get_tree().quit()
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Loading._load_next_scene()
	P1_select_index = 1
	_select_show()
	
	
	if GalleryData.return_to_gallery == true:
		$Gallery/Gallery1.visible = true
		$Gallery/Gallery1._pause_menu_pause_off()
		_pause_menu_pause_on()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2(526, $Start.position.y + 55) 
			$Start.grab_focus()
		2:
			$Select/SelectIcon.position = Vector2(526, $StageSelect.position.y + 55) 
			$StageSelect.grab_focus()
		3:
			$Select/SelectIcon.position = Vector2(526, $Gallery/Gallery_button.position.y + 55) 
			$Gallery/Gallery_button.grab_focus()
		4:
			$Select/SelectIcon.position = Vector2(526, $Setting/Setting.position.y + 55) 
			$Setting/Setting.grab_focus()
		5:
			$Select/SelectIcon.position = Vector2(526, $Exit.position.y + 55) 
			$Exit.grab_focus()
		_:
			print("Default case: Invalid selection")
	
func _pause_menu_off():
	set_process_input(false)
	
func _pause_menu_on():
	set_process_input(true)

func _pause_menu_pause_on():
	set_process_input(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	
