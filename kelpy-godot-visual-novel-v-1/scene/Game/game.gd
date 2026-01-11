extends Node2D


func _ready() -> void:
	pass
	
	##--------------center window
	#var screen_pos = DisplayServer.screen_get_position()
	#var screen_size = DisplayServer.screen_get_size()
#
	#DisplayServer.window_set_size(Vector2i(1280,720))
	## Get the window size including decorations
	#var window_size = get_window().get_size_with_decorations()
#
	## Calculate screen center
	#var screen_center = screen_pos + screen_size / 2
#
	## Set window position so it is centered
	#get_window().set_position(screen_center - window_size / 2)


func _input(event):
	if PopupMessage.visible == false:
		if event is InputEventKey and event.pressed and not event.echo:
			handle_input_action(event)
		elif event is InputEventJoypadButton and event.pressed:
			handle_input_action(event)
		elif event is InputEventJoypadMotion:
			handle_motion_input_action()
	
func handle_input_action(event):
	#AudioSoundBox2d._efxPLAY("select")
			
	if InputMap.event_is_action(event, "UI_control_pause"):
		print("pause")
		get_tree().paused = true
		$PauseMenu_InGame_Dialogue._menu_pausing_toggle(false)
		
				

	
			
func handle_motion_input_action():
	AudioSoundBox2d._efxPLAY("select")
	
	var x = Input.get_action_strength("UI_control_right") - Input.get_action_strength("UI_control_left")
	var y = Input.get_action_strength("UI_control_down") - Input.get_action_strength("UI_control_up")
	if x < -0.5: # left
		pass
	elif x > 0.5: #  right
		pass
	if y < -0.5: #down
		pass
	elif y > 0.5: #up
		pass
			
