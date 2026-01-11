extends Node2D

var P1_select_index = 1

var vol_bus_master := AudioServer.get_bus_index("Master")
var vol_bus_music := AudioServer.get_bus_index("Music")
var vol_bus_sfx := AudioServer.get_bus_index("SFX")
var vol_bus_voice := AudioServer.get_bus_index("Voice")

var canUseEscape = true


func handle_input_action(event):
	Musicbox._efx_select()
	if InputMap.event_is_action(event, "pause"):
		if canUseEscape == true:
				_pause_menu_pause_on()
				$".."._pause_menu_pause_off()
				visible = false
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
			
#				--------volumn
	if InputMap.event_is_action(event, "left"):
		if P1_select_index == 1:
			$vol_master/meter.value = max(0, $vol_master/meter.value - 10)  
			set_master_volume(vol_bus_master,  $vol_master/meter.value)
		elif P1_select_index == 2:
			$vol_music/meter.value = max(0, $vol_music/meter.value - 10)  
			set_master_volume(vol_bus_music, $vol_music/meter.value)
		elif P1_select_index == 3:
			$vol_efx/meter.value = max(0,  $vol_efx/meter.value - 10) 
			set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
		elif P1_select_index == 4:
			Musicbox._voice_ohmygotto()
			$vol_voice/meter.value = max(0,  $vol_voice/meter.value - 10) 
			set_master_volume(vol_bus_voice, $vol_voice/meter.value)
	elif InputMap.event_is_action(event, "right"):
		if P1_select_index == 1:
			$vol_master/meter.value = min(100, $vol_master/meter.value + 10)  
			set_master_volume(vol_bus_master,  $vol_master/meter.value)
		elif P1_select_index == 2:
			$vol_music/meter.value = min(100, $vol_music/meter.value + 10)  
			set_master_volume(vol_bus_music, $vol_music/meter.value)
		elif P1_select_index == 3:
			$vol_efx/meter.value = min(100,  $vol_efx/meter.value + 10) 
			set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
		elif P1_select_index == 4:
			Musicbox._voice_ohmygotto()
			$vol_voice/meter.value = min(100,  $vol_voice/meter.value + 10) 
			set_master_volume(vol_bus_voice, $vol_voice/meter.value)
	
	
	
	
#				--------control
			
	if InputMap.event_is_action(event, "confirm"):
		match P1_select_index:
			1:
				pass
			2:
				pass
			3:
				pass
			4:
				pass
			5:
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
			$vol_master/meter.value = max(0, $vol_master/meter.value - 10)  
			set_master_volume(vol_bus_master,  $vol_master/meter.value)
		elif P1_select_index == 2:
			$vol_music/meter.value = max(0, $vol_music/meter.value - 10)  
			set_master_volume(vol_bus_music, $vol_music/meter.value)
		elif P1_select_index == 3:
			$vol_efx/meter.value = max(0,  $vol_efx/meter.value - 10) 
			set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
		elif P1_select_index == 4:
			Musicbox._voice_ohmygotto()
			$vol_voice/meter.value = max(0,  $vol_voice/meter.value - 10) 
			set_master_volume(vol_bus_voice, $vol_voice/meter.value)
	elif x > 0.5: # right
		if P1_select_index == 1:
			$vol_master/meter.value = min(100, $vol_master/meter.value + 10)  
			set_master_volume(vol_bus_master,  $vol_master/meter.value)
		elif P1_select_index == 2:
			$vol_music/meter.value = min(100, $vol_music/meter.value + 10)  
			set_master_volume(vol_bus_music, $vol_music/meter.value)
		elif P1_select_index == 3:
			$vol_efx/meter.value = min(100,  $vol_efx/meter.value + 10) 
			set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
		elif P1_select_index == 4:
			Musicbox._voice_ohmygotto()
			$vol_voice/meter.value = min(100,  $vol_voice/meter.value + 10) 
			set_master_volume(vol_bus_voice, $vol_voice/meter.value)
	if y < -0.5: #up
		if P1_select_index == 1:
			P1_select_index = 5
		else:
			P1_select_index -= 1 
	elif y > 0.5: # down
		if P1_select_index == 5:
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
##				--------volumn
		#if event.physical_keycode == KEY_LEFT or event.physical_keycode == KEY_A:
			#if P1_select_index == 1:
				#$vol_master/meter.value = max(0, $vol_master/meter.value - 10)  
				#set_master_volume(vol_bus_master,  $vol_master/meter.value)
			#elif P1_select_index == 2:
				#$vol_music/meter.value = max(0, $vol_music/meter.value - 10)  
				#set_master_volume(vol_bus_music, $vol_music/meter.value)
			#elif P1_select_index == 3:
				#$vol_efx/meter.value = max(0,  $vol_efx/meter.value - 10) 
				#set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
			#elif P1_select_index == 4:
				#Musicbox._voice_ohmygotto()
				#$vol_voice/meter.value = max(0,  $vol_voice/meter.value - 10) 
				#set_master_volume(vol_bus_voice, $vol_voice/meter.value)
		#elif event.physical_keycode == KEY_RIGHT or event.physical_keycode == KEY_D:
			#if P1_select_index == 1:
				#$vol_master/meter.value = min(100, $vol_master/meter.value + 10)  
				#set_master_volume(vol_bus_master,  $vol_master/meter.value)
			#elif P1_select_index == 2:
				#$vol_music/meter.value = min(100, $vol_music/meter.value + 10)  
				#set_master_volume(vol_bus_music, $vol_music/meter.value)
			#elif P1_select_index == 3:
				#$vol_efx/meter.value = min(100,  $vol_efx/meter.value + 10) 
				#set_master_volume(vol_bus_sfx, $vol_efx/meter.value)
			#elif P1_select_index == 4:
				#Musicbox._voice_ohmygotto()
				#$vol_voice/meter.value = min(100,  $vol_voice/meter.value + 10) 
				#set_master_volume(vol_bus_voice, $vol_voice/meter.value)
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
					#pass
				#4:
					#pass
				#5:
					#$Back.release_focus()
					#_pause_menu_pause_on()
					#$".."._pause_menu_pause_off()
					#visible = false
				#_:
					#print("Default case: Invalid selection")
					#
		#_select_show()
# Called when the node enters the scene tree for the first time.

	if event is InputEventKey and event.pressed and not event.echo:
		handle_input_action(event)
	elif event is InputEventJoypadButton and event.pressed:
		handle_input_action(event)
	elif event is InputEventJoypadMotion:
		handle_motion_input_action()

func _ready() -> void:
	_pause_menu_pause_on()
	visible = false

	
func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2(328, $vol_master/VolumnIcon.position.y + 40) 
			$Back.release_focus()
		2:
			$Select/SelectIcon.position = Vector2(328, $vol_music/VolumnIcon.position.y + 40) 
		3:
			$Select/SelectIcon.position = Vector2(328, $vol_efx/VolumnIcon.position.y + 40 ) 
		4:
			$Select/SelectIcon.position = Vector2(328, $vol_voice/VolumnIcon.position.y + 40 ) 
			$Back.release_focus()
		5:
			$Select/SelectIcon.position = Vector2(564, $Back.position.y + 55) 
			$Back.grab_focus()
		_:
			print("Default case: Invalid selection")


func _select_reset():
	P1_select_index = 1
	_select_show()
	
	var db_master_value := AudioServer.get_bus_volume_db(vol_bus_master)
	$vol_master/meter.value = db_to_linear(db_master_value) * 100
	var db_music_value := AudioServer.get_bus_volume_db(vol_bus_music)
	$vol_music/meter.value = db_to_linear(db_music_value) * 100
	var db_sfx_value := AudioServer.get_bus_volume_db(vol_bus_sfx)
	$vol_efx/meter.value = db_to_linear(db_sfx_value) * 100
	var db_voice_value := AudioServer.get_bus_volume_db(vol_bus_voice)
	$vol_voice/meter.value = db_to_linear(db_voice_value) * 100
		
	if $vol_master/meter.value < 1:
		$vol_master/VolumnIcon.animation = "mute"
	else:
		$vol_master/VolumnIcon.animation = "default"

	if $vol_music/meter.value < 1:
		$vol_music/VolumnIcon.animation = "mute"
	else:
		$vol_music/VolumnIcon.animation = "default"

	if $vol_efx/meter.value < 1:
		$vol_efx/VolumnIcon.animation = "mute"
	else:
		$vol_efx/VolumnIcon.animation = "default"
		
	if $vol_voice/meter.value < 1:
		$vol_voice/VolumnIcon.animation = "mute"
	else:
		$vol_voice/VolumnIcon.animation = "default"
func _pause_menu_pause_on():
	set_process_input(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	_select_reset()
	
func set_master_volume(vol_bus,value):
	var db_value = -80 if value == 0 else linear_to_db(value / 100.0)  # Clamp at -80 dB
	AudioServer.set_bus_volume_db(vol_bus, db_value)
	save_volume()
	
	match vol_bus:
		vol_bus_master:
			if $vol_master/meter.value < 1:
				$vol_master/VolumnIcon.animation = "mute"
			else:
				$vol_master/VolumnIcon.animation = "default"
		vol_bus_music:
			if $vol_music/meter.value < 1:
				$vol_music/VolumnIcon.animation = "mute"
			else:
				$vol_music/VolumnIcon.animation = "default"
		vol_bus_sfx:
			if $vol_efx/meter.value < 1:
				$vol_efx/VolumnIcon.animation = "mute"
			else:
				$vol_efx/VolumnIcon.animation = "default"
		vol_bus_voice:
			if $vol_voice/meter.value < 1:
				$vol_voice/VolumnIcon.animation = "mute"
			else:
				$vol_voice/VolumnIcon.animation = "default"

		_:
			pass

		

		

	
func save_volume():
	var data = {}
	
	var master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	var sfx_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	var voice_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voice"))
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	#file.store_string(JSON.stringify({"volume_master": master_volume}))
	#file.store_string(JSON.stringify({"volume_music": music_volume}))
	#file.store_string(JSON.stringify({"volume_sfx": sfx_volume}))
	#file.store_string(JSON.stringify({"volume_voice": voice_volume}))
	
	data["volume_master"] = master_volume
	data["volume_music"] = music_volume
	data["volume_sfx"] = sfx_volume
	data["volume_voice"] = voice_volume
	
	file.store_string(JSON.stringify(data))
	file.close()
