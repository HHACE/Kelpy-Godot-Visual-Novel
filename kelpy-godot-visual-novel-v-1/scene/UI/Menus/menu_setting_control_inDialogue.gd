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
	_show_labels_update_v2()
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
	
	
#----------------Update lable key and input from engine
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
	
@onready var buttons_v2 = [
	$Options/Buttons/Key1,
	$Options/Buttons/Key2,
	$Options/Buttons/Key3,
	$Options/Buttons/Key4,
	$Options/Buttons/Key5,
	$Options/Buttons/Key6,
	$Options/Buttons/Key7,
	$Options/Buttons/Back
]

	
	
	
var custom_actions_dialogue = [
	"UI_control_confirm", 
	"UI_control_pause", 
	"Dialogue_control_hide", 
	"Dialogue_control_history", 
	"Dialogue_control_skip", 
	"Dialogue_control_save",
	"Dialogue_control_load",
	"Dialogue_control_auto"
	]
	
var custom_actions_cafe_minigame = [
	"cafe_control_up", 
	"cafe_control_down", 
	"cafe_control_left", 
	"cafe_control_right", 
	"cafe_control_interact", 
	"cafe_control_jump",
	"cafe_control_sprint"
	]
	
var custom_actions_office_minigame = [
	#"cafe_control_up", 
	]
	
@onready var key_action_cointainer = [
	#$Options/Buttons/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer1,
	$Options/Buttons/ScrollContainer/VBoxContainer/HBoxContainer2/VBoxContainer1,
	$Options/Buttons/ScrollContainer/VBoxContainer/HBoxContainer3/VBoxContainer1,
	#$Options/Buttons/ScrollContainer/VBoxContainer/HBoxContainer4/VBoxContainer1
]
var custom_actions_for_key_action_cointainer = [
	#ui
	custom_actions_dialogue,
	custom_actions_cafe_minigame,
	#custom_actions_office_minigame
]

	

func _show_labels_update_v2():
	var action_index = 0  # keep track of which action to assign
	var current_custome_actions_array = []
	for main_node_index in range(0, key_action_cointainer.size()):
		action_index = 0 
		var main_node = key_action_cointainer[main_node_index]
		current_custome_actions_array = custom_actions_for_key_action_cointainer[main_node_index]
		for btn in main_node.get_children():
			print("looping ", btn.name)
			if btn.name.contains("key"):
				var action_label = btn.get_node("Panel/Label")
				
				# Only assign if not already set
				if action_label.text == "Key 1:" and action_index < current_custome_actions_array.size():
					var action_name = current_custome_actions_array[action_index]
					#action_label.text = action_name + ":"
					
					# Collect all key/button/motion events
					var input_names = []
					var events = InputMap.action_get_events(action_name)
					for e in events:
						if e is InputEventKey:
							if OS.get_keycode_string(e.physical_keycode) == "Shift":
								input_names.append("Left Shift")
							else:
								input_names.append(OS.get_keycode_string(e.physical_keycode))
						elif e is InputEventMouseButton:
							match e.button_index:
								MOUSE_BUTTON_LEFT:
									input_names.append("Mouse Left")
								MOUSE_BUTTON_RIGHT:
									input_names.append("Mouse Right")
								MOUSE_BUTTON_MIDDLE:
									input_names.append("Mouse Middle")
								MOUSE_BUTTON_WHEEL_UP:
									input_names.append("Mouse Wheel Up")
								MOUSE_BUTTON_WHEEL_DOWN:
									input_names.append("Mouse Wheel Down")
								_:
									input_names.append("Mouse Button %d" % e.button_index)

					
					# Join them with slash
					action_label.text = " / ".join(input_names) + ":"
					print("/ ",action_label.text)
					print(action_label.name)
					action_index += 1



	
#PRESS--------------


func _on_back_pressed() -> void:
	visible = false
	#save_keybindings()
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)
