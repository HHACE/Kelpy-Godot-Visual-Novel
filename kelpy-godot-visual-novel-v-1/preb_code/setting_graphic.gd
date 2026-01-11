extends Node2D

var P1_select_index = 1

var vol_bus_master := AudioServer.get_bus_index("Master")
var vol_bus_music := AudioServer.get_bus_index("Music")
var vol_bus_sfx := AudioServer.get_bus_index("SFX")

var canUseEscape = true

func handle_input_action(event):
	Musicbox._efx_select()
	if InputMap.event_is_action(event, "pause"):
		if canUseEscape == true:
				_pause_menu_pause_on()
				$".."._pause_menu_pause_off()
				visible = false
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
			
#				--------volumn
	if InputMap.event_is_action(event, "left"):
		if P1_select_index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			$windowMode/fullscreen/box.animation = "checked"
			$windowMode/window/box.animation = "default"
	elif InputMap.event_is_action(event, "right"):
		if P1_select_index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			$windowMode/fullscreen/box.animation = "default"
			$windowMode/window/box.animation = "checked"
			
	
	
	
	
#				--------control
			
	if InputMap.event_is_action(event, "confirm"):
		match P1_select_index:
			1:
				pass
			2:
				pass
			3:
				if ($vsync/box.animation == "checked"):
					$vsync/box.animation= "default" 
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
				else:
					$vsync/box.animation = "checked"
					DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
				#print("Current VSync mode:", DisplayServer.window_get_vsync_mode())
				
			4:
				$Back.release_focus()
				_pause_menu_pause_on()
				$".."._pause_menu_pause_off()
				visible = false
			_:
				print("Default case: Invalid selection")
				
	_select_show()
	
			
func handle_motion_input_action():
	Musicbox._efx_select()
	
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if x < -0.5: # left
		if P1_select_index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			$windowMode/fullscreen/box.animation = "checked"
			$windowMode/window/box.animation = "default"
	elif x > 0.5: # right
		if P1_select_index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			$windowMode/fullscreen/box.animation = "default"
			$windowMode/window/box.animation = "checked"
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
					#_pause_menu_pause_on()
					#$".."._pause_menu_pause_off()
					#visible = false
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
##				--------volumn
		#if event.physical_keycode == KEY_LEFT or event.physical_keycode == KEY_A:
			#if P1_select_index == 1:
				#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				#$windowMode/fullscreen/box.animation = "checked"
				#$windowMode/window/box.animation = "default"
		#elif event.physical_keycode == KEY_RIGHT or event.physical_keycode == KEY_D:
			#if P1_select_index == 1:
				#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				#$windowMode/fullscreen/box.animation = "default"
				#$windowMode/window/box.animation = "checked"
				#
		#
		#
		#
		#
##				--------control
				#
		#if event.physical_keycode == KEY_ENTER or event.physical_keycode == KEY_SPACE:
			#match P1_select_index:
				#1:
					#pass
				#2:
					#pass
				#3:
					#if ($vsync/box.animation == "checked"):
						#$vsync/box.animation= "default" 
						#DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
					#else:
						#$vsync/box.animation = "checked"
						#DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
					##print("Current VSync mode:", DisplayServer.window_get_vsync_mode())
					#
				#4:
					#$Back.release_focus()
					#_pause_menu_pause_on()
					#$".."._pause_menu_pause_off()
					#visible = false
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
	_pause_menu_pause_on()
	visible = false

	
func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2($windowMode/title.position.x -100, $windowMode/title.position.y + 40) 
			$Back.release_focus()
		2:
			$Select/SelectIcon.position = Vector2($resolution/title.position.x , $resolution/title.position.y + 40) 
			
		3:
			$Select/SelectIcon.position = Vector2($vsync/title.position.x , $vsync/title.position.y + 40 ) 
			$Back.release_focus()
		4:
			$Select/SelectIcon.position = Vector2(564, $Back.position.y + 55) 
			$Back.grab_focus()
		_:
			print("Default case: Invalid selection")


func _select_reset():
	P1_select_index = 1
	_select_show()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$windowMode/fullscreen/box.animation = "checked"
		$windowMode/window/box.animation = "default"
	else:
		$windowMode/fullscreen/box.animation = "default"
		$windowMode/window/box.animation = "checked"

	if DisplayServer.window_get_vsync_mode() == 1:
		$vsync/box.animation = "checked"
	else:
		$vsync/box.animation= "default" 
	
	
		
func _pause_menu_pause_on():
	set_process_input(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	_select_reset()
	

		

		

	
#func save_volume():
	#var master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	#var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	#var sfx_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	#var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	#file.store_string(JSON.stringify({"volume_master": master_volume}))
	#file.store_string(JSON.stringify({"volume_music": music_volume}))
	#file.store_string(JSON.stringify({"volume_sfx": sfx_volume}))
	#file.close()
