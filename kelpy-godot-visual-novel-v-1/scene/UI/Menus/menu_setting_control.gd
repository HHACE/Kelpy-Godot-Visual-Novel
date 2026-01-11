extends Node2D

@onready var buttons = [
	$Options/Buttons/Key1,
	$Options/Buttons/Key2,
	$Options/Buttons/Key3,
	$Options/Buttons/Key4,
	$Options/Buttons/Key5,
	$Options/Buttons/Key6,
	$Options/Buttons/Key7,
	$Options/Buttons/Back
]

@onready var buttons_sprite = [
	"Key1",
	"Key2",
	"Key3",
	"Key4",
	"Key5",
	"Key6",
	"Key7",
	$Options/Sprites/Back
]


var custom_actions = [
	"UI_control_up", 
	"UI_control_down", 
	"UI_control_left", 
	"UI_control_right", 
	"UI_control_confirm", 
	"UI_control_back",
	"UI_control_pause"
	]

var P1_select_index = 0

func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	_show_labels_update()
	visible = false
	_menu_pausing_toggle(true)
	

			

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
			
	if InputMap.event_is_action(event, "UI_control_confirm"):
		match P1_select_index:
			#0:
				#start_rebinding("up")
			7:
				visible = false
				#save_keybindings()
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
	else:
		$Options/Buttons/Back.release_focus()
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		if buttons_sprite[i] is AnimatedSprite2D:
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
	else:
		#$Options/SelectIcon/SelectSprite.visible = false
		tween.tween_property(
			$Options/SelectIcon/SelectSprite, 
			"position", 
			Vector2(target_button.get_node("Action").position.x-50, target_button.get_node("Action").position.y+20) , 
			0.15 
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
	
func _show_labels_update():
	var action_index = 0  # keep track of which action to assign
	for btn in buttons:
		if "Key" in btn.name:
			var action_label = btn.get_node("Action/Label")
			var key_label = btn.get_node("Key/Label")
			
			# Only assign if not already set
			if action_label.text == "KEY 1:" and action_index < custom_actions.size():
				var action_name = custom_actions[action_index]
				action_label.text = action_name + ":"
				
				# Collect all key/button/motion events
				var input_names = []
				var events = InputMap.action_get_events(action_name)
				for e in events:
					if e is InputEventKey:
						input_names.append(OS.get_keycode_string(e.physical_keycode))
					elif e is InputEventJoypadButton:
						input_names.append("Button " + str(e.button_index))
					elif e is InputEventJoypadMotion:
						input_names.append("Axis " + str(e.axis))
				
				# Join them with slash
				key_label.text = " / ".join(input_names)
				
				action_index += 1
	
#---------------------------Mapping System
#var waiting_on_cancel_message = false
#var waiting_for_input = false
#var action_to_change = ""
#func start_rebinding(action_name: String):
	#print("Press a key to rebind:", action_name)
	#$Options/Menus/Message1.visible=true
	#action_to_change = action_name
	#waiting_for_input = true
#
#var searchable_actions = ["up", "down", "left", "right", "attack A", "attack B"]
#var searchable_button_actions = ["attack A", "attack B"]
#var searchable_motion_actions = ["up", "down", "left", "right"]
#func rebind_action_keyboard(action_name: String, new_key: int):
	#$AskInput.visible=false
	#
	#var save_action 
	## Remove the key from any other action it's already bound to
	#for action in searchable_actions:
		#for event in InputMap.action_get_events(action):
			#if event is InputEventKey and event.physical_keycode == new_key:
				#InputMap.action_erase_event(action, event)  # Unassign key
				#print("Removed", OS.get_keycode_string(new_key), "from", action)
				#save_action = action
	#
	## Remove existing keys for this action
	#for event in InputMap.action_get_events(action_name):
		#if event is InputEventKey:
			#InputMap.action_erase_event(action_name, event)
			#if save_action != null:
				#InputMap.action_add_event(save_action, event)
#
	## Add new key
	#var new_event = InputEventKey.new()
	#new_event.physical_keycode = new_key
	#InputMap.action_add_event(action_name, new_event)
#
	#print("Rebound ", action_name, "to ", new_key)
	##save_keybindings()
	#_show_labels_update()
#
#func rebind_action_gamepad_button(action_name: String, button_index: int):
	#$AskInput.visible = false
#
	#var save_action 
	## Remove the key from any other action it's already bound to
	#for action in searchable_actions:
		#for event in InputMap.action_get_events(action):
			#if event is InputEventJoypadButton and event.button_index  == button_index:
				#InputMap.action_erase_event(action, event)  # Unassign key
				#print("Removed Button ", button_index, " from ", action)
				#save_action = action
#
#
	## Remove existing gamepad buttons for this action
	#for event in InputMap.action_get_events(action_name):
		#if event is InputEventJoypadButton:
			#InputMap.action_erase_event(action_name, event)
			#
			#if save_action != null:
				#InputMap.action_add_event(save_action, event)
#
	## Add new button
	#var new_event = InputEventJoypadButton.new()
	#new_event.button_index = button_index
	#new_event.pressed = true  # needed so Godot treats it as valid
	#InputMap.action_add_event(action_name, new_event)
#
	#print("Rebound ", action_name, "to Button ", button_index)
	##save_keybindings()
	#_show_labels_update()
#
#func rebind_action_gamepad_motion(action_name: String, axis: int, axis_value: float):
	#$AskInput.visible = false
#
	#var save_action 
	#
	#if action_name not in searchable_motion_actions:
		#waiting_on_cancel_message = true
		#$AskInvalidInput.visible = true
		#return
#
	#for action in searchable_motion_actions:
		#for event in InputMap.action_get_events(action):
			#if event is InputEventJoypadMotion:
				## Check if the direction conflicts (same or opposite)
				#if sign(event.axis_value) == sign(axis_value) and event.axis == axis:
					#InputMap.action_erase_event(action, event)
					#
					#print("Removed axis", event.axis, "value", event.axis_value, "from", action)
					#save_action = action
#
	## Remove existing gamepad buttons for this action
	#for event in InputMap.action_get_events(action_name):
		#if event is InputEventJoypadMotion:
			#InputMap.action_erase_event(action_name, event)
			#if save_action != null:
				#InputMap.action_add_event(save_action, event)
			#
#
	## Add new event
	#var new_event = InputEventJoypadMotion.new()
	#new_event.axis = axis
	#new_event.axis_value = axis_value
	#InputMap.action_add_event(action_name, new_event)
	#
	#print("Rebound", action_name, "to axis", axis, "value", axis_value)
	##save_keybindings()
	#_show_labels_update()
#
#func rebind_action_gamepad_button_trigger(action_name: String, axis: int, axis_value: float):
	#print("called")
	#$AskInput.visible = false
#
	#var save_action 
	#
	#
	#for action in searchable_actions:
		#for event in InputMap.action_get_events(action):
			#if event is InputEventJoypadMotion:
				## Check if the direction conflicts (same or opposite)
				#if sign(event.axis_value) == sign(axis_value) and event.axis == axis:
					#InputMap.action_erase_event(action, event)
					#
					#print("Removed axis", event.axis, " value ", event.axis_value, " from ", action)
					#save_action = action
#
	## Remove existing gamepad buttons for this action
	#for event in InputMap.action_get_events(action_name):
		#if event is InputEventJoypadButton:
			#InputMap.action_erase_event(action_name, event)
			#if save_action != null:
				#InputMap.action_add_event(save_action, event)
				#
		#if event is InputEventJoypadMotion and (event.axis == 4 or event.axis == 5):
			#InputMap.action_erase_event(action_name, event)
			#if save_action != null:
				#InputMap.action_add_event(save_action, event)
			#
	## Add new event
	#var new_event = InputEventJoypadMotion.new()
	#new_event.axis = axis
	#new_event.axis_value = axis_value
	#InputMap.action_add_event(action_name, new_event)
	#
	#print("Rebound", action_name, "to axis", axis, "value", axis_value)
	##save_keybindings()
	#_show_labels_update()

#---------------------------Mapping System---- Save/Load
#func save_keybindings():
	#var bindings = {}
	#for action in custom_actions:
		#var events = InputMap.action_get_events(action)
		#var serialized_events = []
#
		#for e in events:
			#var data = {}
#
			#if e is InputEventKey:
				#data = {
					#"type": "key",
					#"code": e.physical_keycode
				#}
			#elif e is InputEventJoypadButton:
				#data = {
					#"type": "joypad_button",
					#"button_index": e.button_index
				#}
			#elif e is InputEventJoypadMotion:
				#data = {
					#"type": "joypad_motion",
					#"axis": e.axis,
					#"axis_value": e.axis_value
				#}
#
			#if data.size() > 0:
				#serialized_events.append(data)
#
		#if serialized_events.size() > 0:
			#bindings[action] = serialized_events
		#else:
			#bindings[action] = null
#
	## Save to file
	#var file = FileAccess.open("user://controls.json", FileAccess.WRITE)
	#file.store_string(JSON.stringify(bindings))
	#file.close()
	#print("Keybindings saved!")
	
	
	
#func load_keybindings():
	#if not FileAccess.file_exists("user://controls.json"):
		#print("No saved keybindings found.")
		#return
#
	#var file = FileAccess.open("user://controls.json", FileAccess.READ)
	#var data = JSON.parse_string(file.get_as_text())
	#file.close()
#
	#if typeof(data) != TYPE_DICTIONARY:
		#print("Invalid keybinding data.")
		#return
#
	#for action in data.keys():
		#if action in custom_actions:
			#InputMap.action_erase_events(action)  # Clear all old bindings first
#
			#if data[action] == null:
				## No bindings saved → leave it unassigned
				#continue
#
			#for entry in data[action]:
				#var new_event
#
				#match entry["type"]:
					#"key":
						#new_event = InputEventKey.new()
						#new_event.physical_keycode = entry["code"]
#
					#"joypad_button":
						#new_event = InputEventJoypadButton.new()
						#new_event.button_index = entry["button_index"]
#
					#"joypad_motion":
						#new_event = InputEventJoypadMotion.new()
						#new_event.axis = entry["axis"]
						#new_event.axis_value = entry["axis_value"]
#
				#if new_event:
					#InputMap.action_add_event(action, new_event)
#
	#print("Keybindings loaded!")

	
#PRESS--------------


func _on_back_pressed() -> void:
	visible = false
	#save_keybindings()
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)
