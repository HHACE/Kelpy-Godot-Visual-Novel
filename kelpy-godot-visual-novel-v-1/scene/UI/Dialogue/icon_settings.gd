extends CanvasLayer


var icon_menu_open := false

var hide_toggle := false
var skip_toggle := false
var auto_toggle := false
var history_toggle := false

func _ready() -> void:
	_reset_menu()
	start_auto_loop()
	
	Global.connect("_Setting_Dialogue_Changed_", _ON_Setting_Dialogue_Changed_)
	
#-------------------signal

func _ON_Setting_Dialogue_Changed_():
	$Auto_speed.wait_time = Global.user_dialogue_setting["auto_speed"]
	print("Changing Dialogue auto speed")

#-----------------------
	
func _reset_menu():
	icon_menu_open = false
	$Movable_Contents.position.y = -886.345
	
	_visible_buttons_toggle(false)
	$Movable_Contents/Sprites/Arrow.rotation_degrees= 90.0
	$Movable_Contents/Sprites/Arrow.visible = true
	
	_disable_toggle_buttons(true)
	$Movable_Contents/Buttons/Arrow.disabled = false
	$Movable_Contents/Buttons/Arrow.visible = true
	
	$History_panel.visible = false
	

func _disable_toggle_buttons(x: bool):
	for button in $Movable_Contents/Buttons.get_children():
		button.disabled = x
		button.visible = !x
		
func _visible_buttons_toggle(x: bool):
	for sprite in $Movable_Contents/Sprites.get_children():
		if sprite.name != "bookmark":
			sprite.visible = x

#-------------------animation

func Transition_move_in():
	#_disable_toggle_buttons(true)
	_visible_buttons_toggle(true)
	#$Movable_Contents/Sprites/Arrow.visible = true
	var tween = get_tree().create_tween()
		
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property($Movable_Contents, "position", Vector2.ZERO, 1)
	
	
	await tween.finished
	_disable_toggle_buttons(false)
	$Movable_Contents/Sprites/Arrow.visible = true
	$Movable_Contents/Sprites/Arrow.rotation_degrees = -90.0
	
func Transition_move_out():
	_disable_toggle_buttons(true)
	
	var tween = get_tree().create_tween()
		
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property($Movable_Contents, "position", Vector2(0, -886.345), 1)
	
	await tween.finished
	_visible_buttons_toggle(false)
	$Movable_Contents/Sprites/Arrow.rotation_degrees= 90.0
	$Movable_Contents/Sprites/Arrow.visible = true
	$Movable_Contents/Buttons/Arrow.disabled = false
	$Movable_Contents/Buttons/Arrow.visible = true



#-------------------/animation

#-----------------------Buttons icon
func _on_skip_button_down() -> void:
	skip_toggle = true
	
	if $"../SubViewportContainer/SubViewport/Scene/Dialogue/DialogueBox".typing_anim == true:
		$"../SubViewportContainer/SubViewport/Scene/Dialogue".emit_signal("_Dialogue_next_")
	$"../SubViewportContainer/SubViewport/Scene/Dialogue".emit_signal("_Dialogue_next_")
	print("pressed skip: ", skip_toggle)
	


func _on_skip_button_up() -> void:
	skip_toggle = false
	print("pressed skip: ", skip_toggle)




var auto_id = 0
signal _auto_toggled_(on: bool)
func _on_auto_toggled(toggled_on: bool) -> void:
	auto_toggle = toggled_on
	emit_signal("_auto_toggled_", auto_toggle)
	
	if not auto_toggle:
		$Auto_speed.stop()
	else:
		$Auto_speed.wait_time = Global.user_dialogue_setting["auto_speed"]
		$Auto_speed.start()
	
	print("pressed auto: ", auto_toggle)
	
			
func start_auto_loop() -> void:
	while true:
		while not auto_toggle:
			print("wait?")
			await _auto_toggled_
			
		if $"../SubViewportContainer/SubViewport/Scene/Dialogue".dialogue_choice_pick_bool == false and skip_toggle == false and hide_toggle == false and history_toggle == false:
			auto_id += 1
			var current_auto_id = auto_id
			if $"../SubViewportContainer/SubViewport/Scene/Dialogue/DialogueBox".typing_anim == true:
				await $"../SubViewportContainer/SubViewport/Scene/Dialogue/DialogueBox"._Typing_anim_done_
			else:
				print("countdown")
				
				await $Auto_speed.timeout
				
				if current_auto_id == auto_id and auto_toggle == true and ($"../SubViewportContainer/SubViewport/Scene/Dialogue".dialogue_choice_pick_bool == false and skip_toggle == false and hide_toggle == false and history_toggle == false):
					$"../SubViewportContainer/SubViewport/Scene/Dialogue".emit_signal("_Dialogue_next_")
					print("release")
					
		else:
			
			await get_tree().process_frame
			


func _on_history_pressed() -> void:
	history_toggle = !history_toggle
	
	if history_toggle == true:
		$History_panel.visible = true
		await get_tree().process_frame
		$History_panel/TextEdit.scroll_vertical = $History_panel/TextEdit.get_line_count()-1
		print("pressed history COUNT: ", $History_panel/TextEdit.get_line_count())
		
		$History_panel/RichTextLabel.scroll_following_visible_characters = false
		$History_panel/RichTextLabel.scroll_following_visible_characters = true
	else:
		$History_panel.visible = false
		

func _on_history_x_pressed() -> void:
	history_toggle = false
	$History_panel.visible = false
	

func _on_hide_pressed() -> void:
	if history_toggle == false:
		$"../SubViewportContainer/SubViewport/Scene/Dialogue".visible_dialogues_UI_toggle(hide_toggle)
		$".".visible = !visible
		hide_toggle = !hide_toggle
	
	print("pressed hide")


func _on_save_pressed() -> void:
	print("pressed save")
	get_tree().paused = true
	$"../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(false)
	#$"../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(true)
	$"../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue".save_or_load_check = "save"
	$"../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue"._menu_pausing_toggle(false)


func _on_load_pressed() -> void:
	print("pressed load")
	get_tree().paused = true
	$"../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(false)
	#$"../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(true)
	$"../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue".save_or_load_check = "load"
	$"../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue"._menu_pausing_toggle(false)


func _on_setting_pressed() -> void:
	get_tree().paused = true
	$"../PauseMenu_InGame_Dialogue"._menu_pausing_toggle(false)
	$"../PauseMenu_InGame_Dialogue/Options/Menus/Setting_inDialogue"._menu_pausing_toggle(false)
	


func _on_arrow_pressed() -> void:
	print("pressed")
	icon_menu_open = !icon_menu_open
	if icon_menu_open == true:
		#_disable_toggle_buttons(false)
		#$Movable_Contents.position.y = 0 
		#$Movable_Contents/Sprites/Arrow.rotation_degrees = -90.0
		Transition_move_in()
	else:
		#$Movable_Contents.position.y = -886.345
		#$Movable_Contents/Sprites/Arrow.rotation_degrees= 90.0
		#_disable_toggle_buttons(true)
		Transition_move_out()
		

#-----------------------Buttons icon ----------------- mouse hover
func _on_skip_mouse_entered() -> void:
	$Movable_Contents/Buttons/Skip/Panel.visible = true

func _on_auto_mouse_entered() -> void:
	$Movable_Contents/Buttons/Auto/Panel.visible = true


func _on_history_mouse_entered() -> void:
	$Movable_Contents/Buttons/History/Panel.visible = true


func _on_hide_mouse_entered() -> void:
	$Movable_Contents/Buttons/Hide/Panel.visible = true


func _on_save_mouse_entered() -> void:
	$Movable_Contents/Buttons/Save/Panel.visible = true


func _on_load_mouse_entered() -> void:
	$Movable_Contents/Buttons/Load/Panel.visible = true


func _on_setting_mouse_entered() -> void:
	$Movable_Contents/Buttons/Setting/Panel.visible = true
	
#-----------------------Buttons icon ----------------- mouse hover exist

func _on_skip_mouse_exited() -> void:
	$Movable_Contents/Buttons/Skip/Panel.visible = false


func _on_auto_mouse_exited() -> void:
	$Movable_Contents/Buttons/Auto/Panel.visible = false


func _on_history_mouse_exited() -> void:
	$Movable_Contents/Buttons/History/Panel.visible = false


func _on_hide_mouse_exited() -> void:
	$Movable_Contents/Buttons/Hide/Panel.visible = false


func _on_save_mouse_exited() -> void:
	$Movable_Contents/Buttons/Save/Panel.visible = false


func _on_load_mouse_exited() -> void:
	$Movable_Contents/Buttons/Load/Panel.visible = false


func _on_setting_mouse_exited() -> void:
	$Movable_Contents/Buttons/Setting/Panel.visible = false
