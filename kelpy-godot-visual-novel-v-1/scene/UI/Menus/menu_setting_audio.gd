extends Node2D

@onready var buttons = [
	$Options/Buttons/Bus_master,
	$Options/Buttons/Bus_music,
	$Options/Buttons/Bus_efx,
	$Options/Buttons/Bus_voice,
	$Options/Buttons/Back
]

@onready var buttons_sprite = [
	$Options/Sprites/Bus_master,
	$Options/Sprites/Bus_music,
	$Options/Sprites/Bus_efx,
	$Options/Sprites/Bus_voice,
	$Options/Sprites/Back
]


var P1_select_index = 0

func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	visible = false
	_menu_pausing_toggle(true)
	
	var db_master_value := AudioServer.get_bus_volume_db(vol_bus_master)
	$Options/Buttons/Bus_master/ProgressBar.value = db_to_linear(db_master_value) * 100
	var db_music_value := AudioServer.get_bus_volume_db(vol_bus_music)
	$Options/Buttons/Bus_music/ProgressBar.value = db_to_linear(db_music_value) * 100
	var db_sfx_value := AudioServer.get_bus_volume_db(vol_bus_sfx)
	$Options/Buttons/Bus_efx/ProgressBar.value = db_to_linear(db_sfx_value) * 100
	var db_voice_value := AudioServer.get_bus_volume_db(vol_bus_voice)
	$Options/Buttons/Bus_voice/ProgressBar.value = db_to_linear(db_voice_value) * 100
		
	if $Options/Buttons/Bus_master/ProgressBar.value < 1:
		$Options/Sprites/Bus_master.animation = "mute"
	else:
		$Options/Sprites/Bus_master.animation = "default"

	if $Options/Buttons/Bus_music/ProgressBar.value < 1:
		$Options/Sprites/Bus_music.animation = "mute"
	else:
		$Options/Sprites/Bus_music.animation = "default"

	if $Options/Buttons/Bus_efx/ProgressBar.value < 1:
		$Options/Sprites/Bus_efx.animation = "mute"
	else:
		$Options/Sprites/Bus_efx.animation = "default"
		
	if $Options/Buttons/Bus_voice/ProgressBar.value < 1:
		$Options/Sprites/Bus_voice.animation = "mute"
	else:
		$Options/Sprites/Bus_voice.animation = "default"
	

			

func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
		P1_select_index = 0
		_show_select_update()
	else:
		visible = true

func _input(event):
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
			
#				--------volumn
	if InputMap.event_is_action(event, "UI_control_left"):
		if P1_select_index == 0:
			$Options/Buttons/Bus_master/ProgressBar.value = max(0, $Options/Buttons/Bus_master/ProgressBar.value - 10)  
			set_master_volume(vol_bus_master,  $Options/Buttons/Bus_master/ProgressBar.value)
		elif P1_select_index == 1:
			$Options/Buttons/Bus_music/ProgressBar.value = max(0, $Options/Buttons/Bus_music/ProgressBar.value - 10)  
			set_master_volume(vol_bus_music, $Options/Buttons/Bus_music/ProgressBar.value)
		elif P1_select_index == 2:
			$Options/Buttons/Bus_efx/ProgressBar.value = max(0,  $Options/Buttons/Bus_efx/ProgressBar.value - 10) 
			set_master_volume(vol_bus_sfx, $Options/Buttons/Bus_efx/ProgressBar.value)
		elif P1_select_index == 3:
			#Musicbox._voice_ohmygotto()
			$Options/Buttons/Bus_voice/ProgressBar.value = max(0,  $Options/Buttons/Bus_voice/ProgressBar.value - 10) 
			set_master_volume(vol_bus_voice, $Options/Buttons/Bus_voice/ProgressBar.value)
	elif InputMap.event_is_action(event, "UI_control_right"):
		if P1_select_index == 0:
			$Options/Buttons/Bus_master/ProgressBar.value = min(100, $Options/Buttons/Bus_master/ProgressBar.value + 10)  
			set_master_volume(vol_bus_master,  $Options/Buttons/Bus_master/ProgressBar.value)
		elif P1_select_index == 1:
			$Options/Buttons/Bus_music/ProgressBar.value = min(100, $Options/Buttons/Bus_music/ProgressBar.value + 10)  
			set_master_volume(vol_bus_music, $Options/Buttons/Bus_music/ProgressBar.value)
		elif P1_select_index == 2:
			$Options/Buttons/Bus_efx/ProgressBar.value = min(100,  $Options/Buttons/Bus_efx/ProgressBar.value + 10) 
			set_master_volume(vol_bus_sfx, $Options/Buttons/Bus_efx/ProgressBar.value)
		elif P1_select_index == 3:
			#Musicbox._voice_ohmygotto()
			$Options/Buttons/Bus_voice/ProgressBar.value = min(100,  $Options/Buttons/Bus_voice/ProgressBar.value + 10) 
			set_master_volume(vol_bus_voice, $Options/Buttons/Bus_voice/ProgressBar.value)
			
	if InputMap.event_is_action(event, "UI_control_confirm"):
		match P1_select_index:
			4:
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
		if P1_select_index == 0:
			$Options/Buttons/Bus_master/ProgressBar.value = max(0, $Options/Buttons/Bus_master/ProgressBar.value - 10)  
			set_master_volume(vol_bus_master,  $Options/Buttons/Bus_master/ProgressBar.value)
		elif P1_select_index == 1:
			$Options/Buttons/Bus_music/ProgressBar.value = max(0, $Options/Buttons/Bus_music/ProgressBar.value - 10)  
			set_master_volume(vol_bus_music, $Options/Buttons/Bus_music/ProgressBar.value)
		elif P1_select_index == 2:
			$Options/Buttons/Bus_efx/ProgressBar.value = max(0,  $Options/Buttons/Bus_efx/ProgressBar.value - 10) 
			set_master_volume(vol_bus_sfx, $Options/Buttons/Bus_efx/ProgressBar.value)
		elif P1_select_index == 3:
			#Musicbox._voice_ohmygotto()
			$Options/Buttons/Bus_voice/ProgressBar.value = max(0,  $Options/Buttons/Bus_voice/ProgressBar.value - 10) 
			set_master_volume(vol_bus_voice, $Options/Buttons/Bus_voice/ProgressBar.value)
	elif x > 0.5: #  right
		if P1_select_index == 0:
			$Options/Buttons/Bus_master/ProgressBar.value = min(100, $Options/Buttons/Bus_master/ProgressBar.value + 10)  
			set_master_volume(vol_bus_master,  $Options/Buttons/Bus_master/ProgressBar.value)
		elif P1_select_index == 1:
			$Options/Buttons/Bus_music/ProgressBar.value = min(100, $Options/Buttons/Bus_music/ProgressBar.value + 10)  
			set_master_volume(vol_bus_music, $Options/Buttons/Bus_music/ProgressBar.value)
		elif P1_select_index == 2:
			$Options/Buttons/Bus_efx/ProgressBar.value = min(100,  $Options/Buttons/Bus_efx/ProgressBar.value + 10) 
			set_master_volume(vol_bus_sfx, $Options/Buttons/Bus_efx/ProgressBar.value)
		elif P1_select_index == 3:
			#Musicbox._voice_ohmygotto()
			$Options/Buttons/Bus_voice/ProgressBar.value = min(100,  $Options/Buttons/Bus_voice/ProgressBar.value + 10) 
			set_master_volume(vol_bus_voice, $Options/Buttons/Bus_voice/ProgressBar.value)
	if y < -0.5: #down
		P1_select_index = (P1_select_index - 1 + buttons.size()) % buttons.size()

	elif y > 0.5: #up
		P1_select_index = (P1_select_index + 1) % buttons.size()
			
	_show_select_update()



func _show_select_update():
	#for buttons node
	if buttons[P1_select_index] is Button:
		buttons[P1_select_index].grab_focus()
	else:
		$Options/Buttons/Back.release_focus()
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		if buttons_sprite[i] is AnimatedSprite2D and not "Bus" in buttons_sprite[i].name :
			buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	#for selector sprite node
	$Options/SelectIcon/SelectSprite.visible = true
	var target_button = buttons[P1_select_index]
	var tween = create_tween()
	if buttons[P1_select_index] is Button:
		tween.tween_property(
			$Options/SelectIcon/SelectSprite, 
			"position", 
			Vector2(target_button.position.x-50, target_button.position.y+50) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	elif buttons[P1_select_index] is Node2D:
		target_button = buttons_sprite[P1_select_index]
		tween.tween_property(
			$Options/SelectIcon/SelectSprite, 
			"position", 
			Vector2(target_button.position.x-150, target_button.position.y) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		$Options/SelectIcon/SelectSprite.visible = false

	
	
#-------------------Volumn System
var vol_bus_master := AudioServer.get_bus_index("Master")
var vol_bus_music := AudioServer.get_bus_index("Music")
var vol_bus_sfx := AudioServer.get_bus_index("SFX")
var vol_bus_voice := AudioServer.get_bus_index("Voice")

func set_master_volume(vol_bus,value):
	var db_value = -80 if value == 0 else linear_to_db(value / 100.0)  # Clamp at -80 dB
	AudioServer.set_bus_volume_db(vol_bus, db_value)
	#save_volume()
	
	match vol_bus:
		vol_bus_master:
			if $Options/Buttons/Bus_master/ProgressBar.value < 1:
				$Options/Sprites/Bus_master.animation = "mute"
			else:
				$Options/Sprites/Bus_master.animation = "default"
		vol_bus_music:
			if $Options/Buttons/Bus_music/ProgressBar.value < 1:
				$Options/Sprites/Bus_music.animation = "mute"
			else:
				$Options/Sprites/Bus_music.animation = "default"
		vol_bus_sfx:
			if $Options/Buttons/Bus_efx/ProgressBar.value < 1:
				$Options/Sprites/Bus_efx.animation = "mute"
			else:
				$Options/Sprites/Bus_efx.animation = "default"
		vol_bus_voice:
			if $Options/Buttons/Bus_voice/ProgressBar.value < 1:
				$Options/Sprites/Bus_voice.animation = "mute"
			else:
				$Options/Sprites/Bus_voice.animation = "default"

		_:
			pass
	
#func save_volume():
	#var data = {}
	#
	#var master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	#var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	#var sfx_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	#var voice_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voice"))
	#var file = FileAccess.open("user://setting_volumns.json", FileAccess.WRITE)
	#
	#data["volume_master"] = master_volume
	#data["volume_music"] = music_volume
	#data["volume_sfx"] = sfx_volume
	#data["volume_voice"] = voice_volume
	#
	#file.store_string(JSON.stringify(data))
	#file.close()
	
	

#func load_volume():
	#if FileAccess.file_exists("user://setting_volumns.json"):
		#var file = FileAccess.open("user://setting_volumns.json", FileAccess.READ)
		#var parse_result = JSON.parse_string(file.get_as_text())
#
		#file.close()
		#print(parse_result)
		#if parse_result:
			#for action in parse_result.keys():
				#if action == "volume_master":
					#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), parse_result[action])
				#if action == "volume_music":
					#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), parse_result[action])
				#if action == "volume_sfx":
					#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), parse_result[action])
				#if action == "volume_vocie":
					#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), parse_result[action])
				#
#PRESS--------------


func _on_bus_master_progress_bar_drag_ended(value_changed: bool) -> void:
	set_master_volume(vol_bus_master,  $Options/Buttons/Bus_master/ProgressBar.value)

func _on_bus_music_progress_bar_drag_ended(value_changed: bool) -> void:
	set_master_volume(vol_bus_music, $Options/Buttons/Bus_music/ProgressBar.value)

func _on_bus_efx_progress_bar_drag_ended(value_changed: bool) -> void:
	set_master_volume(vol_bus_sfx, $Options/Buttons/Bus_efx/ProgressBar.value)

func _on_bus_voice_progress_bar_drag_ended(value_changed: bool) -> void:
	##Musicbox._voice_ohmygotto()
	set_master_volume(vol_bus_voice, $Options/Buttons/Bus_voice/ProgressBar.value)


func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)
