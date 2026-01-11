extends Node2D

@onready var buttons = [
	$Options/Buttons/Back
]

@onready var buttons_sprite = [
	$Options/Sprites/Back
]


var P1_select_index = 0

func _ready() -> void:
	P1_select_index = 0
	_show_select_update()
	
	visible = false
	_menu_pausing_toggle(true)

func _menu_pausing_toggle(input: bool):
	set_process_input(!input)
	set_process(!input)
	if input == true:
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
			0:
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
	buttons[P1_select_index].grab_focus()
		
	#for buttons sprite node
	for i in range(buttons_sprite.size()):
		buttons_sprite[i].animation = "highlight" if i == P1_select_index else "default" 

	#for selector sprite node
	var target_button = buttons[P1_select_index]
	var tween = create_tween()
	tween.tween_property(
		$Options/SelectIcon/SelectSprite, 
		"position", 
		Vector2(target_button.position.x-50, target_button.position.y+50) , 
		0.15 
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
#PRESS--------------


func _on_back_pressed() -> void:
	visible = false
	_menu_pausing_toggle(true)
	$"../../.."._menu_pausing_toggle(false)
