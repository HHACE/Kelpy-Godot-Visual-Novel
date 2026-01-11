extends Node2D

var ComicIndex = 1
var pageindex = 1

var animation_page_finsh_bool = false



func _ready() -> void:
	load_volume()
	load_keybindings()
	
#	----------
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#self.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event):
	if (event is InputEventKey and event.is_pressed() and not event.is_echo()) or (event is InputEventJoypadButton and event.is_pressed()):  # Check if it's a key event and the key is pressed
		#if InputMap.event_is_action(event, "confirm"):
		if animation_page_finsh_bool == false:
			Musicbox._efx_pageFlip()
			_page_animation()


var skip_timer := 0.0
func _process(delta):
	if Input.is_anything_pressed():
		skip_timer += delta
		if skip_timer >= 2:
			set_process_input(false)
			set_process(false)
			$Loading._move_to_next_scene("res://Scenes/MainMenu.tscn")
	else:
		skip_timer = 0.0

			
func _page_animation():
	var tween = create_tween()
	
	var start_position = $comic1/comic1p1.position
	var end_position = Vector2(960, 540)  # Replace with your target position
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	var comicNodePath = "comic%d/comic%dp%d" % [ComicIndex, ComicIndex, pageindex]
	print(comicNodePath)
	var comicNode = get_node(comicNodePath)
	print(comicNode)
	tween.parallel().tween_property(comicNode, "position", end_position, 0.5)
	
	pageindex+=1
		
#	------------wait for page animation
	if ComicIndex == 1 and pageindex==7-1:
		print("wait")
		animation_page_finsh_bool = true
		await get_tree().create_timer(0.25).timeout
		animation_page_finsh_bool = false
	if ComicIndex == 2 and pageindex==6-1:
		print("wait")
		animation_page_finsh_bool = true
		await get_tree().create_timer(0.25).timeout
		animation_page_finsh_bool = false
	if ComicIndex == 3 and pageindex==7-1:
		print("wait")
		animation_page_finsh_bool = true
		await get_tree().create_timer(0.25).timeout
		animation_page_finsh_bool = false
	if ComicIndex == 4 and pageindex==13-1:
		print("wait")
		animation_page_finsh_bool = true
		await get_tree().create_timer(0.5).timeout
		animation_page_finsh_bool = false


#	------------next page

	if ComicIndex == 1 and pageindex==7:

		ComicIndex +=1
		pageindex=1
		tween.parallel().tween_property($comic1, "position", Vector2(-3800, 0), 0.5)
		#await get_tree().create_timer(0.5).timeout
		_page_animation()
	if ComicIndex == 2 and pageindex==6:

		ComicIndex +=1
		pageindex=1
		tween.parallel().tween_property($comic2, "position", Vector2(-3800, 0), 0.5)
		#await get_tree().create_timer(0.5).timeout
		_page_animation()
	if ComicIndex == 3 and pageindex==7:

		ComicIndex +=1
		pageindex=1
		tween.parallel().tween_property($comic3, "position", Vector2(-3800, 0), 0.5)
		#await get_tree().create_timer(0.5).timeout
		_page_animation()
	if ComicIndex == 4 and pageindex==13:
		ComicIndex +=1
		pageindex=1
		#get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		set_process_input(false)
		$Loading._move_to_next_scene("res://Scenes/MainMenu.tscn")





func load_volume():
	if FileAccess.file_exists("user://settings.json"):
		var file = FileAccess.open("user://settings.json", FileAccess.READ)
		#var json = JSON.new()
		var parse_result = JSON.parse_string(file.get_as_text())

		file.close()
		print(parse_result)
		if parse_result:
			for action in parse_result.keys():
				if action == "volume_master":
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), parse_result[action])
				if action == "volume_music":
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), parse_result[action])
				if action == "volume_sfx":
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), parse_result[action])
				if action == "volume_vocie":
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), parse_result[action])
				

var custom_actions = [
	"attack A", "attack B", "bot guard",
	"up", "down", "left", "right"
]  # Only save these

func load_keybindings():
	if not FileAccess.file_exists("user://controls.json"):
		print("No saved keybindings found.")
		return

	var file = FileAccess.open("user://controls.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if typeof(data) != TYPE_DICTIONARY:
		print("Invalid keybinding data.")
		return

	for action in data.keys():
		if action in custom_actions:
			InputMap.action_erase_events(action)  # Clear all old bindings first

			if data[action] == null:
				# No bindings saved → leave it unassigned
				continue

			for entry in data[action]:
				var new_event

				match entry["type"]:
					"key":
						new_event = InputEventKey.new()
						new_event.physical_keycode = entry["code"]

					"joypad_button":
						new_event = InputEventJoypadButton.new()
						new_event.button_index = entry["button_index"]

					"joypad_motion":
						new_event = InputEventJoypadMotion.new()
						new_event.axis = entry["axis"]
						new_event.axis_value = entry["axis_value"]

				if new_event:
					InputMap.action_add_event(action, new_event)

	print("Keybindings loaded!")
