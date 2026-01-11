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
	
	refresh_save_buttons()
	#highlight_current_page_button()

	
func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
		P1_select_index = 0
		P1_select_horizontal_index = 0
		_show_select_update()
	else:
		visible = true
		$"../SaveLoad_inDialogue/Label".text = save_or_load_check.capitalize()

		
func _input(event):
	pass
	#if event is InputEventKey and event.pressed and not event.echo:
		#handle_input_action(event)
	#elif event is InputEventJoypadButton and event.pressed:
		#handle_input_action(event)
	#elif event is InputEventJoypadMotion:
		#handle_motion_input_action()
	
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
		$"../SaveLoad_inDialogue/Options/SelectIcon/ColorRect".visible = true
		if buttons_file[P1_select_horizontal_index] != null:
			buttons_file[P1_select_horizontal_index].grab_focus()
	else:
		$"../SaveLoad_inDialogue/Options/SelectIcon/ColorRect".visible = false
		if buttons[P1_select_index] != null:
			buttons[P1_select_index].grab_focus()
	
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		if buttons_sprite[i] != null:
			buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	##for selector sprite node
	#if P1_select_index == 0:
		#var target_button = buttons_file[P1_select_horizontal_index]
		#var tween = create_tween()
		#tween.tween_property(
			##$Options/SelectIcon/SelectSprite, 
			##"position", 
			##Vector2(target_button.position.x-50, target_button.position.y+50) , 
			##0.15 
			##40.0 160.0
			##60.0 182.0
			#$"../SaveLoad_inDialogue/Options/SelectIcon/ColorRect",
			#"position", 
			#Vector2(target_button.position.x-20, target_button.position.y-22) , 
			#0.15 
		#).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
# SAVE FUNCTIONS------------------------
#func save_thumbnail(path: String):
	#get_game_screenshot()

	
func save_thumbnail(path: String):
	#$"../../../../Icon_Settings".visible = false
	#await get_tree().process_frame
	#await get_tree().process_frame
	#print($"../../../../Icon_Settings".visible)
	var vp := $"../../../../SubViewportContainer/SubViewport/Scene".get_viewport()
	
	var tex: Texture2D = vp.get_texture()
	var img: Image = tex.get_image()
	#img.flip_y()  # correct orientation
	img.resize(524, 453, Image.INTERPOLATE_BILINEAR)
	
	#$"../../../../Icon_Settings".visible = true
	
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
	
	if file:
		file.store_string(json)
		file.close()
		print("Saved game to ", path)
	else:
		push_error("Failed to open file: %s" % FileAccess.get_open_error())
	
func force_auto_save():
	var path := ""
	
	for i in range(1,4+1):
		var temp_path = "user://save/save_" + "A" + str(i) + ".json"
		if !FileAccess.file_exists(temp_path):
			path = temp_path
			break
	if path == "":
		path = find_oldest_auto_save()
	
	save_thumbnail(path)
	
func get_save_date(path: String) -> int:
	if not FileAccess.file_exists(path):
		return -1

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return -1

	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if data == null:
		return -1

	if data.has("user") and data["user"].has("date"):
		return parse_save_date(data["user"]["date"])

	return -1


func parse_save_date(date_str: String) -> int:
	# "2026-01-10, 16:58"
	var parts := date_str.split(", ")
	if parts.size() != 2:
		return -1

	var date := parts[0].split("-")
	var time := parts[1].split(":")

	if date.size() != 3 or time.size() != 2:
		return -1

	var dt := {
		"year": date[0].to_int(),
		"month": date[1].to_int(),
		"day": date[2].to_int(),
		"hour": time[0].to_int(),
		"minute": time[1].to_int(),
		"second": 0
	}

	return Time.get_unix_time_from_datetime_dict(dt)

func find_oldest_auto_save() -> String:
	var oldest_time := INF
	var oldest_path := ""

	for i in range(1, 5):
		var path := "user://save/save_A%d.json" % i
		var date := get_save_date(path)

		if date == -1:
			continue

		if date < oldest_time:
			oldest_time = date
			oldest_path = path

	return oldest_path

	
func load_save_thumbnail(path: String, file_slot: String) -> Texture2D:
	#var img := Image.load_from_file(path)
	
	var encoded
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parse_result = JSON.parse_string(file.get_as_text())

		file.close()
		#print(parse_result)
		if parse_result:
			for main_data in parse_result.keys():
				if main_data == "game":
					for data in parse_result[main_data]:
						if data == "Variables":
							var title_label := $"../SaveLoad_inDialogue/Options/Menus".get_node("File%d/Title" % file_slot.to_int())
							title_label.text = parse_result[main_data][data]["chapter_title"]
				if main_data == "user":
					for data in parse_result[main_data]:
						if data == "thumbnail":
							encoded = parse_result[main_data][data]
						if data == "date":
							var date_label := $"../SaveLoad_inDialogue/Options/Menus".get_node("File%d/Date" % file_slot.to_int())
							date_label.text = parse_result[main_data][data]

	
		var decoded = Marshalls.base64_to_raw(encoded)
		var img = Image.new()
		img.load_png_from_buffer(decoded)

		return ImageTexture.create_from_image(img)
	else:
		var title_label := $"../SaveLoad_inDialogue/Options/Menus".get_node("File%d/Title" % file_slot.to_int())
		title_label.text = ""
		var date_label := $"../SaveLoad_inDialogue/Options/Menus".get_node("File%d/Date" % file_slot.to_int())
		date_label.text = ""
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
							
							
							
							
							
#--------page
const SLOTS_PER_PAGE := 4

var current_page := "1" 



func refresh_save_buttons():
		
	for file_slot in range(1,SLOTS_PER_PAGE+1):
		var path = "user://save/save_" + "1" + ".json"
		
		if current_page.is_valid_int():
			var save_number = file_slot + ((current_page.to_int()-1) * SLOTS_PER_PAGE) 
			path = "user://save/save_" + str(save_number) + ".json"
		else:
			path = "user://save/save_" + "A" + str(file_slot) + ".json"
			
		#print(path)
		#print(load_save_thumbnail(path, str(file_slot)) != null)
		
		var slot_file_node = $"../SaveLoad_inDialogue/Options/Menus".get_node("File%d/TextureRect" % file_slot)
		if load_save_thumbnail(path, str(file_slot)) != null:
			slot_file_node.texture = load_save_thumbnail(path, str(file_slot))
		else:
			
			slot_file_node.texture = preload("res://icon.svg")
		
func highlight_current_page_button():
	#print("page ",current_page)
	for child in $Options/Buttons/Pages_buttons.get_children():
		if child.button_pressed == true:
			child.button_pressed = false
			
	var page_button_node = $Options/Buttons/Pages_buttons.get_node(current_page)
	page_button_node.button_pressed = true
	
#--------/page



#PRESS--------------


func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)


func _on_file_x_pressed(number: String) -> void:
	var path = ""
	if current_page.is_valid_int():
		var save_number = number.to_int() + ((current_page.to_int()-1) * SLOTS_PER_PAGE) 
		path = "user://save/save_" + str(save_number) + ".json"
	else:
		path = "user://save/save_" + "A" + number + ".json"
		if save_or_load_check == "save":
			PopupMessage.setup_popup_message("Can't save to automatic save slot.", 1, ["OK"])
			return
	
	if FileAccess.file_exists(path):
		var file := FileAccess.open(path, FileAccess.READ)
		if file:
			if file.get_length() == 0:
				print("file exists but is empty")
			else:
				print("file exists and has data")
				if save_or_load_check == "save":
					PopupMessage.setup_popup_message("Are you sure you want to overwrite this save?", 2, ["No", "Yes"])
				else:
					PopupMessage.setup_popup_message("Loading will lose unsaved progress\nAre you sure you want to load?", 2, ["No", "Yes"])
				var result: String = await PopupMessage._PopUp_Message_pressed_
				if result == "Yes":
					print("User accepted")
				else:
					return
			file.close()
	else:
		print("file does not exist")
		if save_or_load_check == "load":
			PopupMessage.setup_popup_message("This save slot is empty", 1, ["OK"])
			return

	
	
	if save_or_load_check == "save":
		
		save_thumbnail(path)
		await get_tree().process_frame
		await get_tree().process_frame
		$Options/Menus.get_node("File"+number+"/TextureRect").texture = load_save_thumbnail(path, number)
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

func _on_page_x_pressed(number: String) -> void:
	current_page = number
	refresh_save_buttons()
	highlight_current_page_button()

func _buttons_disable(input: bool):
	for i in buttons:
		if i is Button:
			i.disabled = input
	for i in buttons_file:
		if i is Button:
			i.disabled = input
