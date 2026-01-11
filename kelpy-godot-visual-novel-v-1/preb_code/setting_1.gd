extends Node2D

var P1_select_index = 1


var canUseEscape = true

func handle_input_action(event):
		Musicbox._efx_select()
		if InputMap.event_is_action(event, "pause"):
			if canUseEscape == true:
					_pause_menu_pause_on()
					$"../.."._pause_menu_pause_off()
					visible = false
		if InputMap.event_is_action(event, "down"):
			if P1_select_index == 4:
				P1_select_index = 1 
			else:
				P1_select_index += 1 
				
		elif InputMap.event_is_action(event, "up"):
			if P1_select_index == 1:
				P1_select_index = 4
			else:
				P1_select_index -= 1 
				
		
		
		
		
#				--------control
				
		if InputMap.event_is_action(event, "confirm"):
			match P1_select_index:
				1:
					_pause_menu_pause_on()
					$control.visible=true
					$control._pause_menu_pause_off()
					
				2:
					_pause_menu_pause_on()
					$volumn.visible=true
					$volumn._pause_menu_pause_off()
				3:
					_pause_menu_pause_on()
					$graphic.visible=true
					$graphic._pause_menu_pause_off()
				4:
					$Back.release_focus()
					_pause_menu_pause_on()
					#if get_tree().current_scene.name != "MainMenu":
					$"../.."._pause_menu_pause_off()
					visible = false
				_:
					print("Default case: Invalid selection")
					
		_select_show()
	
			
func handle_motion_input_action():
	Musicbox._efx_select()
	
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if x < -0.5: # left
		pass
	elif x > 0.5: # right
		pass
	if y < -0.5: #up
		if P1_select_index == 1:
			P1_select_index = 4
		else:
			P1_select_index -= 1 
	elif y > 0.5: # down
		if P1_select_index == 4:
			P1_select_index = 1 
		else:
			P1_select_index += 1 
			
	_select_show()

func _input(event):
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():  # Check if it's a key event and the key is pressed
		#Musicbox._efx_select()
		#if event.physical_keycode == KEY_ESCAPE:
			#if canUseEscape == true:
					#_pause_menu_pause_on()
					#$"../.."._pause_menu_pause_off()
					#visible = false
		#if event.physical_keycode == KEY_DOWN or event.physical_keycode == KEY_S:
			#if P1_select_index == 4:
				#P1_select_index = 1 
			#else:
				#P1_select_index += 1 
				#
		#elif event.physical_keycode == KEY_UP or event.physical_keycode == KEY_W:
			#if P1_select_index == 1:
				#P1_select_index = 4
			#else:
				#P1_select_index -= 1 
				#
		#
		#
		#
		#
##				--------control
				#
		#if event.physical_keycode == KEY_ENTER or event.physical_keycode == KEY_SPACE:
			#match P1_select_index:
				#1:
					#_pause_menu_pause_on()
					#$control.visible=true
					#$control._pause_menu_pause_off()
					#
				#2:
					#_pause_menu_pause_on()
					#$volumn.visible=true
					#$volumn._pause_menu_pause_off()
				#3:
					#_pause_menu_pause_on()
					#$graphic.visible=true
					#$graphic._pause_menu_pause_off()
				#4:
					#$Back.release_focus()
					#_pause_menu_pause_on()
					##if get_tree().current_scene.name != "MainMenu":
					#$"../.."._pause_menu_pause_off()
					#visible = false
				#_:
					#print("Default case: Invalid selection")
					#
		#_select_show()
# Called when the node enters the scene tree for the first time.
	
	if event is InputEventKey and event.pressed and not event.echo:
		handle_input_action(event)
	elif event is InputEventJoypadButton and event.pressed:
		handle_input_action(event)
	elif event is InputEventJoypadMotion:
		handle_motion_input_action()

func _ready() -> void:
	_pause_menu_pause_on()
	visible = false

	
func _select_show():
	match P1_select_index:
		1:
			$Select/SelectIcon.position = Vector2(564, $Control.position.y + 55) 
			$Control.grab_focus()
		2:
			$Select/SelectIcon.position = Vector2(564, $Volumn.position.y + 55 ) 
			$Volumn.grab_focus()
		3:
			$Select/SelectIcon.position = Vector2(564, $Graphic.position.y + 55) 
			$Graphic.grab_focus()
		4:
			$Select/SelectIcon.position = Vector2(564, $Back.position.y + 55) 
			$Back.grab_focus()
		_:
			print("Default case: Invalid selection")


func _select_reset():
	P1_select_index = 1
	_select_show()
	
		
func _pause_menu_pause_on():
	set_process_input(false)
	
func _pause_menu_pause_off():
	set_process_input(true)
	_select_reset()
