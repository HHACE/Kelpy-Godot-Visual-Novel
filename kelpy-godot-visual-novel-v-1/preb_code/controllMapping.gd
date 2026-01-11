extends Node2D

var P1_select_index = 1

var canUseEscape = true

func handle_input_action(event):
	Musicbox._efx_select()
	if InputMap.event_is_action(event, "pause"):
		if canUseEscape == true:
				_pause_menu_pause_on()
				$".."._pause_menu_pause_off()
				visible = false
				#save_keybindings()
	if InputMap.event_is_action(event, "down"):
		if P1_select_index == 7:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	elif InputMap.event_is_action(event, "up"):
		if P1_select_index == 1:
			P1_select_index = 7
		else:
			P1_select_index -= 1 
			
	if InputMap.event_is_action(event, "confirm"):
		match P1_select_index:
			1:
				start_rebinding("up")
			2:
				start_rebinding("down")
			3:
				start_rebinding("left")
			4:
				start_rebinding("right")
			5:
				start_rebinding("attack A")
			6:
				start_rebinding("attack B")
			7:
				$Back.release_focus()
				_pause_menu_pause_on()
				$".."._pause_menu_pause_off()
				visible = false
				save_keybindings()
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
			P1_select_index = 7
		else:
			P1_select_index -= 1 
	elif y > 0.5:
		if P1_select_index == 7:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	_select_show()

func _input(event):
	if event is InputEventJoypadMotion and abs(event.axis_value) < 0.2:
		return
	if waiting_on_cancel_message:
		waiting_on_cancel_message = false
		$AskInvalidInput.visible=false
		return
#		----------------------
	if waiting_for_input and InputMap.event_is_action(event, "pause"):
		waiting_for_input = false
		$AskInput.visible=false
		return
	elif waiting_for_input and event is InputEventKey and event.is_pressed():
		Musicbox._efx_select()
		# Assign new input key
		rebind_action_keyboard(action_to_change, event.physical_keycode)
		waiting_for_input = false
		return  # Prevent double input
	elif waiting_for_input and event is InputEventJoypadButton and event.pressed:
		Musicbox._efx_select()
		rebind_action_gamepad_button(action_to_change, event.button_index)
		waiting_for_input = false
		return
	elif waiting_for_input and event is InputEventJoypadMotion:
		# Only accept if stick moved past threshold
		if abs(event.axis_value) > 0.5 and (event.axis != 4 and event.axis != 5):
			Musicbox._efx_select()
			rebind_action_gamepad_motion(action_to_change, event.axis, sign(event.axis_value))
			waiting_for_input = false
			return
		elif abs(event.axis_value) > 0.5 and (event.axis == 4 or event.axis == 5):
			Musicbox._efx_select()
			rebind_action_gamepad_button_trigger(action_to_change, event.axis, sign(event.axis_value))
			waiting_for_input = false
			return
		
	if event is InputEventKey and event.pressed and not event.echo:
		handle_input_action(event)
	elif event is InputEventJoypadButton and event.pressed:
		handle_input_action(event)
	elif event is InputEventJoypadMotion:
		handle_motion_input_action()
	

func _ready() -> void:
	_pause_menu_pause_on()
	visible = false
	update_ui_labels_all()
	_select_show()


var skip_timer := 0.0
func _process(delta):
	if Input.is_action_pressed("back"):
		skip_timer += delta
		if skip_timer >= 2:
			reset_to_default()
			skip_timer = 0.0
	else:
		skip_timer = 0.0


var waiting_on_cancel_message = false
var waiting_for_input = false
var action_to_change = ""
func start_rebinding(action_name: String):
	print("Press a key to rebind:", action_name)
	$AskInput.visible=true
	action_to_change = action_name
	waiting_for_input = true

var searchable_actions = ["up", "down", "left", "right", "attack A", "attack B"]
var searchable_button_actions = ["attack A", "attack B"]
var searchable_motion_actions = ["up", "down", "left", "right"]
func rebind_action_keyboard(action_name: String, new_key: int):
	$AskInput.visible=false
	
	var save_action 
	# Remove the key from any other action it's already bound to
	for action in searchable_actions:
		for event in InputMap.action_get_events(action):
			if event is InputEventKey and event.physical_keycode == new_key:
				InputMap.action_erase_event(action, event)  # Unassign key
				print("Removed", OS.get_keycode_string(new_key), "from", action)
				save_action = action
		#--------------------------
	#for existing_action in InputMap.get_actions():
		#for event in InputMap.action_get_events(existing_action):
			#if event is InputEventKey and event.physical_keycode == new_key:
				#InputMap.action_erase_event(existing_action, event)  # Unassign key from old action
				#print("Removed", OS.get_keycode_string(new_key), "from", existing_action)
				#save_action = existing_action
	
	# Remove existing keys for this action
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey:
			InputMap.action_erase_event(action_name, event)
			if save_action != null:
				InputMap.action_add_event(save_action, event)

	# Add new key
	var new_event = InputEventKey.new()
	new_event.physical_keycode = new_key
	InputMap.action_add_event(action_name, new_event)

	print("Rebound ", action_name, "to ", new_key)
	#save_keybindings()
	update_ui_labels_all()

func rebind_action_gamepad_button(action_name: String, button_index: int):
	$AskInput.visible = false

	var save_action 
	# Remove the key from any other action it's already bound to
	for action in searchable_actions:
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadButton and event.button_index  == button_index:
				InputMap.action_erase_event(action, event)  # Unassign key
				print("Removed Button ", button_index, " from ", action)
				save_action = action


	# Remove existing gamepad buttons for this action
	for event in InputMap.action_get_events(action_name):
		if event is InputEventJoypadButton:
			InputMap.action_erase_event(action_name, event)
			
			if save_action != null:
				InputMap.action_add_event(save_action, event)

	# Add new button
	var new_event = InputEventJoypadButton.new()
	new_event.button_index = button_index
	new_event.pressed = true  # needed so Godot treats it as valid
	InputMap.action_add_event(action_name, new_event)

	print("Rebound ", action_name, "to Button ", button_index)
	#save_keybindings()
	update_ui_labels_all()

func rebind_action_gamepad_motion(action_name: String, axis: int, axis_value: float):
	$AskInput.visible = false

	var save_action 
	
	if action_name not in searchable_motion_actions:
		waiting_on_cancel_message = true
		$AskInvalidInput.visible = true
		return
	

	for action in searchable_motion_actions:
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadMotion:
				# Check if the direction conflicts (same or opposite)
				if sign(event.axis_value) == sign(axis_value) and event.axis == axis:
					InputMap.action_erase_event(action, event)
					
					print("Removed axis", event.axis, "value", event.axis_value, "from", action)
					save_action = action

						
			#elif event is InputEventJoypadButton and action == action_name:
				#InputMap.action_erase_event(action, event)
				#save_other_motion_input = null
				#save_button_input = event
				#print("add")
#				----------------------------
	# Remove existing gamepad buttons for this action
	for event in InputMap.action_get_events(action_name):
		if event is InputEventJoypadMotion:
			InputMap.action_erase_event(action_name, event)
			if save_action != null:
				InputMap.action_add_event(save_action, event)
			

	# Add new event
	var new_event = InputEventJoypadMotion.new()
	new_event.axis = axis
	new_event.axis_value = axis_value
	InputMap.action_add_event(action_name, new_event)
	
	#if save_action != null and save_other_motion_input != null:
		#InputMap.action_add_event(save_action, save_other_motion_input)
	#elif save_button_input != null:
		#InputMap.action_add_event(save_action, save_button_input)
		

	print("Rebound", action_name, "to axis", axis, "value", axis_value)
	#save_keybindings()
	update_ui_labels_all()

func rebind_action_gamepad_button_trigger(action_name: String, axis: int, axis_value: float):
	print("called")
	$AskInput.visible = false

	var save_action 
	
	
	for action in searchable_actions:
		for event in InputMap.action_get_events(action):
			if event is InputEventJoypadMotion:
				# Check if the direction conflicts (same or opposite)
				if sign(event.axis_value) == sign(axis_value) and event.axis == axis:
					InputMap.action_erase_event(action, event)
					
					print("Removed axis", event.axis, " value ", event.axis_value, " from ", action)
					save_action = action

	# Remove existing gamepad buttons for this action
	for event in InputMap.action_get_events(action_name):
		if event is InputEventJoypadButton:
			InputMap.action_erase_event(action_name, event)
			if save_action != null:
				InputMap.action_add_event(save_action, event)
				
		if event is InputEventJoypadMotion and (event.axis == 4 or event.axis == 5):
			InputMap.action_erase_event(action_name, event)
			if save_action != null:
				InputMap.action_add_event(save_action, event)
			
	# Add new event
	var new_event = InputEventJoypadMotion.new()
	new_event.axis = axis
	new_event.axis_value = axis_value
	InputMap.action_add_event(action_name, new_event)
	
	print("Rebound", action_name, "to axis", axis, "value", axis_value)
	#save_keybindings()
	update_ui_labels_all()

func update_ui_labels(action_name: String):
	var events = InputMap.action_get_events(action_name)
	var key_name = "Unassigned"
	if events.size() > 0 and events[0] is InputEventKey:
		key_name = OS.get_keycode_string(events[0].physical_keycode)
	match action_name:
		"up":
			$Up/Input.text = key_name
		"down":
			$Down/Input.text = key_name
		"left":
			$Left/Input.text = key_name
		"right":
			$Right/Input.text = key_name
		"attack A":
			$A/Input.text = key_name
		"attack B":
			$B/Input.text = key_name
	#print(key_name)
		
		
var joypad_buttons = {
	0: "A",
	1: "B",
	2: "X",
	3: "Y",
	4: "Back",
	5: "Guide",
	6: "Start",
	7: "Left Stick",
	8: "Right Stick",
	9: "LB",
	10: "RB",
	11: "DPad Up",
	12: "DPad Down",
	13: "DPad Left",
	14: "DPad Right",
	15: "Button 15"

}


#var joypad_axes = {
	#0: "Left Stick Up",
	#1: "Left Stick Down",
	#2: "Left Stick Right",
	#3: "Left Stick Left",
	#4: "L2 Trigger",
	#5: "R2 Trigger"
#}

var key_names = []
func update_ui_labels_all():
	for action in ["up", "down", "left", "right", "attack A", "attack B"]:
		var events = InputMap.action_get_events(action)
		var key_name = ""
		
	# Look for a keyboard key first
		for e in events:
			if e is InputEventKey:
				key_names.append(OS.get_keycode_string(e.physical_keycode))
# Fallback if nothing assigned
		key_name = " / ".join(key_names) if key_names.size() > 0 else "Unassigned"
		key_names.clear()
		match action:
			"up":
				$Up/Input.text = key_name
			"down":
				$Down/Input.text = key_name
			"left":
				$Left/Input.text = key_name
			"right":
				$Right/Input.text = key_name
			"attack A":
				$A/Input.text = key_name
			"attack B":
				$B/Input.text = key_name
				
				
		## If no keyboard found, fall back to gamepad button/axis ----------------------------------------------------
		#if key_name == "Unassigned":
		for e in events:
			


			if e is InputEventJoypadMotion:
				if e.axis == 0:  # Left Stick X
					if e.axis_value < -0.5:
						#print("Left")
						#key_name = "Stick Left"
						key_names.append("LStick Left")
					elif e.axis_value > 0.5:
						#print("Right")
						#key_name = "Stick Right"
						key_names.append("LStick Right")
				elif e.axis == 1:  # Left Stick Y
					if e.axis_value < -0.5:
						#key_name = "Stick Up"
						key_names.append("LStick Up")
					elif e.axis_value > 0.5:
						#key_name = "Stick Down"
						key_names.append("LStick Down")
				if e.axis == 2:  # Right Stick X
					if e.axis_value < -0.5:
						#print("Left")
						#key_name = "Stick Left"
						key_names.append("RStick Left")
					elif e.axis_value > 0.5:
						#print("Right")
						#key_name = "Stick Right"
						key_names.append("RStick Right")
				elif e.axis == 3:  # Right Stick Y
					if e.axis_value < -0.5:
						#key_name = "Stick Up"
						key_names.append("RStick Up")
					elif e.axis_value > 0.5:
						#key_name = "Stick Down"
						key_names.append("RStick Down")
				elif e.axis == 4:  # Trigger button
					if e.axis_value > 0.5:
						key_names.append("Left Trigger")
				elif e.axis == 5:  # Trigger button
					if e.axis_value > 0.5:
						key_names.append("Right Trigger")
				
			if e is InputEventJoypadButton:
				#key_name = joypad_buttons.get(e.button_index, "Button " + str(e.button_index))
				key_names.append(joypad_buttons.get(e.button_index, "Button " + str(e.button_index)))
				#break
				
		key_name = " / ".join(key_names) if key_names.size() > 0 else "Unassigned"
		key_names.clear()
		match action:
			"up":
				$Up/InputController.text = key_name
			"down":
				$Down/InputController.text = key_name
			"left":
				$Left/InputController.text = key_name
			"right":
				$Right/InputController.text = key_name
			"attack A":
				$A/InputController.text = key_name
			"attack B":
				$B/InputController.text = key_name
	#print(key_name)
		
func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2(328, $Up/Sprite2D.position.y + 20) 
			$Back.release_focus()
			$Select/SelectIcon.visible = false
			$Select/ReferenceRect.visible = true
			$Select/ReferenceRect.position = Vector2(136.0, 122.0) 
		2:
			$Select/SelectIcon.position = Vector2(328, $Down/Sprite2D.position.y + 20 + 120) 
			$Select/ReferenceRect.position = Vector2(136.0, 240.0) 
		3:
			$Select/SelectIcon.position = Vector2(328, $Left/Sprite2D.position.y + 20 + 120 *2) 
			$Select/ReferenceRect.position = Vector2(136.0, 360.0) 
		4:
			$Select/SelectIcon.position = Vector2(328, $Right/Sprite2D.position.y + 20 + 120*3) 
			$Select/ReferenceRect.position = Vector2(136.0, 480.0) 
		5:
			$Select/SelectIcon.position = Vector2(328, $A/Sprite2D.position.y + 20 + 120*4) 
			$Select/ReferenceRect.position = Vector2(136.0, 600.0) 
		6:
			$Select/SelectIcon.position = Vector2(328, $B/Sprite2D.position.y + 20 + 120*5)
			$Back.release_focus()
			$Select/SelectIcon.visible = false
			$Select/ReferenceRect.visible = true
			$Select/ReferenceRect.position = Vector2(136.0, 720.0) 
		7:
			$Select/SelectIcon.position = Vector2(564, $Back.position.y + 55) 
			$Back.grab_focus()
			$Select/SelectIcon.visible = true
			$Select/ReferenceRect.visible = false
	
		_:
			print("Default case: Invalid selection")


func _select_reset():
	P1_select_index = 1
	$Select/SelectIcon.position = Vector2(328, $Up/Sprite2D.position.y + 20) 
	$Select/SelectIcon.visible = false
	$Select/ReferenceRect.visible = true
	$Select/ReferenceRect.position = Vector2(136.0, 122.0) 
	$Back.release_focus()
	
		
func _pause_menu_pause_on():
	set_process_input(false)
	set_process(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	set_process(true)
	_select_reset()



func reset_to_default():
	for action in custom_actions:
		# First remove all current bindings
		for e in InputMap.action_get_events(action):
			InputMap.action_erase_event(action, e)
		
		# Add default bindings (example)
		match action:
			"up":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_W
				InputMap.action_add_event(action, input_key)
				
				var input_motion = InputEventJoypadMotion.new()
				input_motion.axis = 1
				input_motion.axis_value = -1
				InputMap.action_add_event(action, input_motion)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 11
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
			"down":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_S
				InputMap.action_add_event(action, input_key)
				
				var input_motion = InputEventJoypadMotion.new()
				input_motion.axis = 1
				input_motion.axis_value = 1
				InputMap.action_add_event(action, input_motion)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 12
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
			"left":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_A
				InputMap.action_add_event(action, input_key)
				
				var input_motion = InputEventJoypadMotion.new()
				input_motion.axis = 0
				input_motion.axis_value = -1
				InputMap.action_add_event(action, input_motion)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 13
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
			"right":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_D
				InputMap.action_add_event(action, input_key)
				
				var input_motion = InputEventJoypadMotion.new()
				input_motion.axis = 0
				input_motion.axis_value = 1
				InputMap.action_add_event(action, input_motion)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 14
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
			"attack A":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_J
				InputMap.action_add_event(action, input_key)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 2
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
			"attack B":
				var input_key = InputEventKey.new()
				input_key.physical_keycode = KEY_K
				InputMap.action_add_event(action, input_key)
				
				var input_button = InputEventJoypadButton.new()
				input_button.button_index = 0
				input_button.pressed = true 
				InputMap.action_add_event(action, input_button)
	update_ui_labels_all()  

var custom_actions = [
	"attack A", "attack B", "bot guard",
	"up", "down", "left", "right"
]  # Only save these

func save_keybindings():
	var bindings = {}

	# Save only custom actions
	#for action in custom_actions:
		#var events = InputMap.action_get_events(action)
		#if events.size() > 0 and events[0] is InputEventKey:
			#bindings[action] = events[0].physical_keycode  # Save keycode
		#else:
			#bindings[action] = null  # Mark unassigned inputs
			
	for action in custom_actions:
		var events = InputMap.action_get_events(action)
		var serialized_events = []

		for e in events:
			var data = {}

			if e is InputEventKey:
				data = {
					"type": "key",
					"code": e.physical_keycode
				}
			elif e is InputEventJoypadButton:
				data = {
					"type": "joypad_button",
					"button_index": e.button_index
				}
			elif e is InputEventJoypadMotion:
				data = {
					"type": "joypad_motion",
					"axis": e.axis,
					"axis_value": e.axis_value
				}

			if data.size() > 0:
				serialized_events.append(data)

		if serialized_events.size() > 0:
			bindings[action] = serialized_events
		else:
			bindings[action] = null

	# Save to file
	var file = FileAccess.open("user://controls.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(bindings))
	file.close()
	print("Keybindings saved!")
