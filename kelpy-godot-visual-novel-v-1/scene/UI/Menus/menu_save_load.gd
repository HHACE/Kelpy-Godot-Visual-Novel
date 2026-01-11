extends Node2D

@onready var buttons = [
	null,
	$Options/Buttons/Back
]

@onready var buttons_file = [
	$Options/Buttons/file1,
	$Options/Buttons/file2,
	$Options/Buttons/file3
]

@onready var buttons_sprite = [
	null,
	null,
	null,
	$Options/Sprites/Back
]

var save_or_load_check = "" #save / load

var P1_select_index = 0

var P1_select_horizontal_index = 0
var P1_select_vertical_index = 0


func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	
	visible = false
	_menu_pausing_toggle(true)
	
	if load_save_thumbnail("user://save/save_1.json") != null:
		$Options/Menus/File1/TextureRect.texture = load_save_thumbnail("user://save/save_1.json")
	if load_save_thumbnail("user://save/save_2.json") != null:
		$Options/Menus/File2/TextureRect.texture = load_save_thumbnail("user://save/save_2.json") 
	if load_save_thumbnail("user://save/save_3.json") != null:
		$Options/Menus/File3/TextureRect.texture = load_save_thumbnail("user://save/save_3.json")

	#$Options/Buttons/file1.pressed.connect(_on_file_x_pressed.bind($Options/Buttons/file1))
	#$Options/Buttons/file2.pressed.connect(_on_file_x_pressed.bind($Options/Buttons/file2))
	#$Options/Buttons/file3.pressed.connect(_on_file_x_pressed.bind($Options/Buttons/file3))
	
func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
		P1_select_index = 0
		P1_select_horizontal_index = 0
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
		
	if InputMap.event_is_action(event, "UI_control_right"):
		P1_select_horizontal_index = (P1_select_horizontal_index + 1) % buttons_file.size()
	if InputMap.event_is_action(event, "UI_control_left"):
		P1_select_horizontal_index = (P1_select_horizontal_index - 1 + buttons_file.size()) % buttons_file.size()
			
	if InputMap.event_is_action(event, "UI_control_confirm"):
		match P1_select_index:
			0:
				match P1_select_horizontal_index:
					0:
						pass
					1:
						pass
					2:
						pass
			1:
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
	if P1_select_index == 0:
		$Options/SelectIcon/ColorRect.visible = true
		if buttons_file[P1_select_horizontal_index] != null:
			buttons_file[P1_select_horizontal_index].grab_focus()
	else:
		$Options/SelectIcon/ColorRect.visible = false
		if buttons[P1_select_index] != null:
			buttons[P1_select_index].grab_focus()
	
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		if buttons_sprite[i] != null:
			buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	#for selector sprite node
	if P1_select_index == 0:
		var target_button = buttons_file[P1_select_horizontal_index]
		var tween = create_tween()
		tween.tween_property(
			#$Options/SelectIcon/SelectSprite, 
			#"position", 
			#Vector2(target_button.position.x-50, target_button.position.y+50) , 
			#0.15 
			#40.0 160.0
			#60.0 182.0
			$Options/SelectIcon/ColorRect,
			"position", 
			Vector2(target_button.position.x-20, target_button.position.y-22) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
# SAVE FUNCTIONS------------------------
#func save_thumbnail(path: String):
	#get_game_screenshot()

	
func save_thumbnail(path: String):
	$"../../../../SubViewportContainer/SubViewport/Scene/Icon_Settings".visible = false
	await get_tree().process_frame
	await get_tree().process_frame
	print($"../../../../SubViewportContainer/SubViewport/Scene/Icon_Settings".visible)
	var vp := $"../../../../SubViewportContainer/SubViewport/Scene".get_viewport()
	
	var tex: Texture2D = vp.get_texture()
	var img: Image = tex.get_image()
	#img.flip_y()  # correct orientation
	img.resize(524, 453, Image.INTERPOLATE_BILINEAR)
	
	$"../../../../SubViewportContainer/SubViewport/Scene/Icon_Settings".visible = true
	
	var bytes = img.save_png_to_buffer()
	var encoded = Marshalls.raw_to_base64(bytes)

	var iso_time = Time.get_datetime_string_from_system()
	var parts = iso_time.split("T")  # ["2025-12-07", "18:33:15"]
	var date_part = parts[0]
	var time_part = parts[1].substr(0, 5)  # take "HH:MM"
	var formatted = date_part + ", " + time_part
	#print(formatted)
	
	var user_data = {
		"date": formatted,
		"vars": "game_state",
		"thumbnail": encoded
	}
	
	var save_data = {
		"game": Global.stage_data,
		"user": user_data
	}
	
	#return img
	
	# Convert to JSON
	var json = JSON.stringify(save_data)
	
	# Write to file
	#var path = "user://save/save_" + str(1) + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	#file.store_string(json)
	#file.close()
	#print("Saved game to ", path)
	
	if FileAccess.open(path, FileAccess.ModeFlags.WRITE_READ) != null:
		file.store_string(json)
		file.close()
	else:
		push_error(FileAccess.get_open_error())
	
func load_save_thumbnail(path: String) -> Texture2D:
	#var img := Image.load_from_file(path)
	
	var encoded
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parse_result = JSON.parse_string(file.get_as_text())

		file.close()
		#print(parse_result)
		if parse_result:
			for main_data in parse_result.keys():
				#if main_data == "game":
					#pass
				if main_data == "user":
					for data in parse_result[main_data]:
						if data == "thumbnail":
							encoded = parse_result[main_data][data]
						if data == "date":
							$Options/Menus/File1/Date.text = parse_result[main_data][data]
							var file_name := path.get_file()      # save_1.json
							var base := file_name.get_basename()  # save_1
							var index_str := base.replace("save_", "")
							var date_label := $Options/Menus.get_node(
						"File%d/Date" % index_str.to_int()
					)
							date_label.text = parse_result[main_data][data]

	
		var decoded = Marshalls.base64_to_raw(encoded)
		var img = Image.new()
		img.load_png_from_buffer(decoded)

		return ImageTexture.create_from_image(img)
	else:
		return

# LOADING FUNCTIONS------------------------
func load_file(path: String):
	#var img := Image.load_from_file(path)

	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parse_result = JSON.parse_string(file.get_as_text())
		
		Global.stage_data["Characters"].clear()
		Global.stage_data= {
			"Characters": [],
			"Dialogue" : [],
			"Variables" : {"cafe":0, "office":0},
			"Dialogue_Log":[],
			"Scene" : "Dialogue"
		}
		
		file.close()
		#print(parse_result)
		if parse_result:
			for main_data in parse_result.keys():
				#if main_data == "game":
					#pass
				if main_data == "game":
					for data in parse_result[main_data]:
						if data == "Characters":
							Global.stage_data["Characters"] = parse_result[main_data][data]
						if data == "Dialogue":
							Global.stage_data["Dialogue"] = parse_result[main_data][data]
						if data == "Dialogue_Log":
							Global.stage_data["Dialogue_Log"] = parse_result[main_data][data]
						if data == "Variables":
							Global.stage_data["Variables"] = parse_result[main_data][data]
						if data == "Scene":
							Global.stage_data["Scene"] = parse_result[main_data][data]
	print(Global.stage_data)
							
							
							
#PRESS--------------

#--------page
const SLOTS_PER_PAGE := 4

var current_page := "" 

func _on_next_page_pressed(number: String):
	current_page = number
	refresh_save_buttons()

func refresh_save_buttons():
		
	for file_slot in range(1,SLOTS_PER_PAGE):
		var path = "user://save/save_" + "1" + ".json"
		
		if current_page.is_valid_int():
			var save_number = file_slot + (current_page.to_int()-1 * SLOTS_PER_PAGE) 
			path = "user://save/save_" + str(save_number) + ".json"
		else:
			path = "user://save/save_" + "A" + str(file_slot) + ".json"
		
		if load_save_thumbnail(path) != null:
			$Options/Menus/File1/TextureRect.texture = load_save_thumbnail(path)
		
#--------/page



func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)


func _on_file_x_pressed(number: String) -> void:
	print(number)
	
	var path = ""
	if current_page.is_valid_int():
		var save_number = number.to_int() + (current_page.to_int()-1 * SLOTS_PER_PAGE) 
		path = "user://save/save_" + str(save_number) + ".json"
	else:
		path = "user://save/save_" + "A" + number + ".json"

	if save_or_load_check == "save":
		
		save_thumbnail(path)
		await get_tree().process_frame
		await get_tree().process_frame
		$Options/Menus.get_node("File"+number+"/TextureRect").texture = load_save_thumbnail(path)
		#$Options/Menus/File1/TextureRect.texture = load_save_thumbnail(path)
	else:
		get_tree().paused = false
		_menu_pausing_toggle(true)
		_buttons_disable(true)
		#for new game
		load_file(path)
		await TransitionScreen.fade_in()
		Global.loading_next_scene_path = "res://scene/Game/Game.tscn"
		get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")



func _buttons_disable(input: bool):
	for i in buttons:
		if i is Button:
			i.disabled = input
	for i in buttons_file:
		if i is Button:
			i.disabled = input
