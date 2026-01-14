extends Node2D

@onready var buttons = [
	$"Options/Buttons/Box Resolution",
	$"Options/Buttons/Box Window Mode",
	$"Options/Buttons/Box Vsync",
	$Options/Buttons/Back
]

@onready var buttons_sprite = [
	"Key1",
	"Key2",
	"Key3",
	$Options/Sprites/Back
]


var P1_select_index = 0

func _ready() -> void:
	load_graphics()
	
	P1_select_index = 0
	_show_select_update()
	visible = false
	_menu_pausing_toggle(true)
	
	
	for i in resolutions:
		$"Options/Buttons/Box Resolution/OptionButton".add_item(i)
		
	#var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolution_index = resolutions.keys().find("1920x1080")
	$"Options/Buttons/Box Resolution/OptionButton".selected = resolution_index
	resolution_option_index = resolution_index
	
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = false
		$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = true
	else:
		$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = true
		$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = false
	
	if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
		$"Options/Buttons/Box Vsync/CheckBox".button_pressed = true

			

func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
		P1_select_index = 0
		_show_select_update()
		
	else:
		visible = true
		$"Options/Buttons/Box Resolution/OptionButton".grab_focus()

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		handle_input_action(event)
	elif event is InputEventJoypadButton and event.pressed:
		handle_input_action(event)
	elif event is InputEventJoypadMotion:
		handle_motion_input_action()
	
func handle_input_action(event):
	AudioSoundBox2d._efxPLAY("select")
	
	if $"Options/Buttons/Box Resolution/OptionButton".get_popup().visible == false:
		
		if InputMap.event_is_action(event, "UI_control_down"):
			P1_select_index = (P1_select_index + 1) % buttons.size()
		if InputMap.event_is_action(event, "UI_control_up"):
			P1_select_index = (P1_select_index - 1 + buttons.size()) % buttons.size()
			
		if InputMap.event_is_action(event, "UI_control_left"):
			if P1_select_index == 1:
				window_mode_option_index = (window_mode_option_index - 1 + 2) % 2  # cycles 0↔1
		if InputMap.event_is_action(event, "UI_control_right"):
			if P1_select_index == 1:
				window_mode_option_index = (window_mode_option_index + 1) % 2  # cycles 0↔1
		
				
		if InputMap.event_is_action(event, "UI_control_confirm"):
			match P1_select_index:
				0:
					$"Options/Buttons/Box Resolution/OptionButton".get_popup()
				1:
					match window_mode_option_index:
						0:
							if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
								#$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = true
								$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = false
								DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
							#else:
								#$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = true
						1:
							if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
								$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = false
								#$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = true
								DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
							#else:
								#$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = true
				2:
					if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
						#$vsync/box.animation= "default" 
						#$"Options/Buttons/Box Vsync/CheckBox".button_pressed = false
						DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
					else:
						#$vsync/box.animation = "checked"
						#$"Options/Buttons/Box Vsync/CheckBox".button_pressed = true
						DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
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
	if buttons[P1_select_index] is Button:
		buttons[P1_select_index].grab_focus()
	elif "Box Resolution" in buttons[P1_select_index].name:
		buttons[P1_select_index].get_node("OptionButton").grab_focus()
	elif "Box Window Mode" in buttons[P1_select_index].name:
		if window_mode_option_index == 0:
			buttons[P1_select_index].get_node("CheckBox").grab_focus()
		else:
			buttons[P1_select_index].get_node("CheckBox2").grab_focus()
	elif "Box Vsync" in buttons[P1_select_index].name:
		buttons[P1_select_index].get_node("CheckBox").grab_focus()
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		if buttons_sprite[i] is AnimatedSprite2D:
			buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	#for selector sprite node
	$Options/SelectIcon/SelectSprite.visible = true
	var target_button = buttons[P1_select_index]
	var tween = create_tween()
	if "Box" in buttons[P1_select_index].name:
		#target_button = $"Options/Buttons/Box Resolution/Label"
		target_button = buttons[P1_select_index].get_node("Label")
		tween.tween_property(
			$Options/SelectIcon/SelectSprite, 
			"position", 
			Vector2(target_button.position.x-50, target_button.position.y+25) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		return
	
	if buttons[P1_select_index] is Button:
		tween.tween_property(
			$Options/SelectIcon/SelectSprite, 
			"position", 
			Vector2(target_button.position.x-50, target_button.position.y+50) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		$Options/SelectIcon/SelectSprite.visible = false

#-------------------------Resolution Setting
var resolution_option_index = 0


var resolutions = {
	#"3840x2160": Vector2i(3840,2160),
	#"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	#"1366x768": Vector2i(1366,768),
	#"1280x720": Vector2i(1280,720),
	#"1440x900": Vector2i(1440,900),
	#"1600x900": Vector2i(1600,900),
	#"1024x600": Vector2i(1024,600),
	#"800x600": Vector2i(800,600)
}
	
	
#-------------------------Window Mode Setting
var window_mode_option_index = 0

#PRESS--------------



func _on_Resolution_option_button_item_selected(index: int) -> void:
	var ob = $"Options/Buttons/Box Resolution/OptionButton"
	ob.select(index)
	var key = ob.get_item_text(index)
	var new_size = resolutions[key]

	## Change window size only
	#DisplayServer.window_set_size(new_size)
#
	## Keep viewport scale consistent
	#var root_vp = get_tree().root
	#root_vp.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	#root_vp.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	#
##	--------------center window
	#var screen_pos = DisplayServer.screen_get_position()
	#var screen_size = DisplayServer.screen_get_size()
#
	## Get the window size including decorations
	#var window_size = get_window().get_size_with_decorations()
#
	## Calculate screen center
	#var screen_center = screen_pos + screen_size / 2
#
	## Set window position so it is centered
	#get_window().set_position(screen_center - window_size / 2)

#Save and load---------------------

func save_graphics():
	var json = JSON.stringify(Global.user_graphic_setting)
	var file = FileAccess.open("user://user_settings/setting_graphics.json", FileAccess.WRITE)
	
	if FileAccess.open("user://user_settings/setting_graphics.json", FileAccess.ModeFlags.WRITE_READ) != null:
		file.store_string(json)
		file.close()
	else:
		push_error(FileAccess.get_open_error())
	

func load_graphics():
	
	if FileAccess.file_exists("user://user_settings/setting_graphics.json"):
		var file = FileAccess.open("user://user_settings/setting_graphics.json", FileAccess.READ)
		var parse_result = JSON.parse_string(file.get_as_text())

		file.close()
		print(parse_result)
		if parse_result:
			for action in parse_result.keys():
				if action == "window_mode":
					Global.user_graphic_setting["window_mode"] = parse_result[action]
					
					if parse_result[action] == "Window":
						if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
							$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = true
							$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = false
							DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					if parse_result[action] == "Fullscreen":
						if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
							$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = false
							$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = true
							DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
					
				if action == "vsync":
					Global.user_graphic_setting["vsync"] = parse_result[action]
					
					if parse_result[action] == true:
						DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
					if parse_result[action] == false:
						DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


				




#PRESS------------------
func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)


func _on_window_check_box_pressed() -> void:
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		#$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = true
		$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		Global.user_graphic_setting["window_mode"] = "Window"
		
	save_graphics()


func _on_fullscreen_check_box_2_pressed() -> void:
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		$"Options/Buttons/Box Window Mode/CheckBox".button_pressed = false
		#$"Options/Buttons/Box Window Mode/CheckBox2".button_pressed = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
		Global.user_graphic_setting["window_mode"] = "Fullscreen"
		
	save_graphics()

func _on_vsync_check_box_pressed() -> void:
	
	if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Global.user_graphic_setting["vsync"] = false
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Global.user_graphic_setting["vsync"] = true
	save_graphics()
