extends Node2D

var current_option_buttons = []

var p_select_vertical_index = 0

var input_first_interaction = false

func _ready() -> void:
	_menu_pausing_toggle(true)

func handle_input_action(event):
	#if InputMap.event_is_action(event, "confirm"):
	#if Input.is_action_just_pressed("ui_accept"):
		#emit_signal("_Dialogue_next_")
	#print("call")
	if input_first_interaction ==false:
		input_first_interaction = true
		_show_select_update()
		return
	if InputMap.event_is_action(event, "UI_control_down"):
		p_select_vertical_index = (p_select_vertical_index + 1) % current_option_buttons.size()
	if InputMap.event_is_action(event, "UI_control_up"):
		p_select_vertical_index = (p_select_vertical_index - 1 + current_option_buttons.size()) % current_option_buttons.size()

	#if InputMap.event_is_action(event, "UI_control_confirm"):
		#_menu_pausing_toggle(true)

	_show_select_update()


func _input(event: InputEvent) -> void:

	if PopupMessage.visible == false:
		if event is InputEventKey and event.pressed and not event.echo:
			handle_input_action(event)
		elif event is InputEventJoypadButton and event.pressed:
			handle_input_action(event)
	
func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	visible = !input
	if input == true:
		input_first_interaction = false
		p_select_vertical_index = 0
	#else:
		#visible = true
		
func _buttons_checking():
	current_option_buttons.clear()
	p_select_vertical_index = 0
	#$CenterContainer/HBoxContainer.get_children()
	for i in $CenterContainer/HBoxContainer.get_children():
		current_option_buttons.append(i)
	#print($CenterContainer/HBoxContainer.get_children())
	#for i in current_option_buttons:
		#print(i.name)
	_menu_pausing_toggle(false)
	input_first_interaction = false
	
func _show_select_update():
	print(p_select_vertical_index)
	print(current_option_buttons[p_select_vertical_index])
	current_option_buttons[p_select_vertical_index].call_deferred("grab_focus")
