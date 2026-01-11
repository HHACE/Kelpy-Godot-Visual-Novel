extends CanvasLayer


signal _Dialogue_next_
signal _Dialogue_choice_pick_
#signal _Dialogue_end_
#var dialogue_index = 0
var dialogue_data_current
#var target_NPC
var dialogue_log = []
var dialogue_log_stack_depth = 0
var dialogue_route_enter = true
var dialogue_choice_pick_bool = false

@onready var Icon_menu_node = $"../../../../Icon_Settings"

func _ready() -> void:
	#_set_all_process(false)
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	
	#load_dialogue("dialogue_loading_test")
	
	if Global.stage_data["Scene"] == "Dialogue":
		loading_data_sprite()
		
	if Global.stage_data["Dialogue"].size() > 0:
		load_dialogue(Global.stage_data["Dialogue"])
		#load_dialogue(Global.stage_data["Dialogue"].back()["name"])
	#elif Global.stage_data["Dialogue"].size() > 1:
		#pass
		
	#load_dialogue("dialogue_loading_test")
	
	#match get_tree().current_scene.name:
		#"GameVsMisso":
			#dialogue_data_current = DialogueData.missco_stage1_intro
		#"Game":
			#dialogue_data_current = DialogueData.missco_stage1_intro
		#_:
			#pass
			
			
	


func handle_input_action(event):
	if Icon_menu_node.hide_toggle == true:
		Icon_menu_node._on_hide_pressed()
		visible_dialogues_UI_toggle(true)
		return
	#if InputMap.event_is_action(event, "confirm"):
	if Input.is_action_just_pressed("UI_control_confirm"):
		
		#Musicbox._efx_select()
		#if dialogue_index < dialogue_data_current.size() - 1:
			#dialogue_index += 1
			#show_current_dialogue()
			
		emit_signal("_Dialogue_next_")
		#$DialogueBox.skip_text()
		#else:
			#_set_all_process(false)
			
	if Input.is_action_just_pressed("Dialogue_control_history"):
		Icon_menu_node._on_history_pressed()
	if Input.is_action_just_pressed("Dialogue_control_hide"):
		Icon_menu_node._on_hide_pressed()
	if Input.is_action_just_pressed("Dialogue_control_skip"):
		Icon_menu_node._on_skip_button_down()
	if Input.is_action_just_pressed("Dialogue_control_auto"):
		Icon_menu_node.get_node("Movable_Contents/Buttons/Auto").button_pressed = !Icon_menu_node.auto_toggle
		#Icon_menu_node._on_auto_toggled(!Icon_menu_node.auto_toggle)
	if Input.is_action_just_pressed("Dialogue_control_save"):
		Icon_menu_node._on_save_pressed()
	if Input.is_action_just_pressed("Dialogue_control_load"):
		Icon_menu_node._on_load_pressed()
		
		
func _is_mouse_over_ui_icon() -> bool:
	var hovered = get_viewport().gui_get_hovered_control()
	#print(hovered.name)
	if hovered.get_parent().get_parent().get_parent().name == "Icon_Settings" or Icon_menu_node.history_toggle == true:
		return true
	return false

func _input(event: InputEvent) -> void:
	if PopupMessage.visible == false:
		
		if event is InputEventMouseButton and event.pressed and not event.is_echo():
			#if InputMap.event_is_action(event, "confirm"):
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and _is_mouse_over_ui_icon() == false:
				if Icon_menu_node.hide_toggle == true:
					Icon_menu_node._on_hide_pressed()
					visible_dialogues_UI_toggle(true)
					return
					
				emit_signal("_Dialogue_next_")
				if Icon_menu_node.auto_toggle == true:
					Icon_menu_node.auto_id += 1
					
					
		
		
				
		if event is InputEventKey and event.pressed and not event.echo:
			handle_input_action(event)
		elif event is InputEventKey and not event.pressed :
			if Input.is_action_just_released("Dialogue_control_skip"):
				Icon_menu_node._on_skip_button_up()
		elif event is InputEventJoypadButton and event.pressed:
			handle_input_action(event)
		#elif event is InputEventJoypadMotion:
			#handle_motion_input_action()
	
func load_dialogue(target_datas):
	#dialogue_data_current = DialogueData.get(target_data)
	
	var starting_label_array = DialogueData.get(target_datas[0]["name"])
	
	if target_datas.size() > 1:
		#---------------------------------------
		if target_datas[target_datas.size()-1]["type"] != "Label":
			for dict_index in range(target_datas.size()-1, 0-1, -1):
				if Global.stage_data["Dialogue"][dict_index]["type"] == "Label":
					starting_label_array = DialogueData.get(target_datas[dict_index]["name"])
					
					for i in range(dict_index+1, target_datas.size()):
						var entry = target_datas[i]
						var key = entry["name"]
						starting_label_array = starting_label_array[target_datas[i-1]["index"]]["options"][key]
						dialogue_data_current = starting_label_array
					break
		else:
			starting_label_array = DialogueData.get(target_datas[target_datas.size()-1]["name"])
			dialogue_data_current = starting_label_array
	else:
		dialogue_data_current = starting_label_array
				
	
	load_logs_history()

	await _set_all_process(true)
	show_current_dialogue()
	

func load_logs_history():
	Icon_menu_node.get_node("History_panel/RichTextLabel").clear()
	var starting_label_array
	var same_label_begining_index = 0
	for i in range(0, Global.stage_data["Dialogue_Log"].size()) :
		
		same_label_begining_index = 0
		for l in range(i-1, 0-1 , -1):
			if Global.stage_data["Dialogue_Log"][l]["stack_depth"] == Global.stage_data["Dialogue_Log"][i]["stack_depth"]:
				same_label_begining_index = Global.stage_data["Dialogue_Log"][l]["index"]
			elif Global.stage_data["Dialogue_Log"][l]["stack_depth"] < Global.stage_data["Dialogue_Log"][i]["stack_depth"]:
				break
				
		
				
		if Global.stage_data["Dialogue_Log"][i]["type"] == "Label":
			starting_label_array = DialogueData.get(Global.stage_data["Dialogue_Log"][i]["name"])
			print("Label: ", starting_label_array)
		else:
			for l in range(i-1, 0-1 , -1):
				if Global.stage_data["Dialogue_Log"][l]["type"] == "Label":
					starting_label_array = DialogueData.get(Global.stage_data["Dialogue_Log"][l]["name"])
					var array = starting_label_array
					var key = Global.stage_data["Dialogue_Log"][i]["name"]
					
					for ll in range(l, i):
						if  Global.stage_data["Dialogue_Log"][ll]["stack_depth"] < Global.stage_data["Dialogue_Log"][i]["stack_depth"]:
							key = Global.stage_data["Dialogue_Log"][ll+1]["name"]
							var key_index = int(Global.stage_data["Dialogue_Log"][ll]["index"])
							print("------------------")
							print(key)
							print(key_index)
							print("check the aray ",array[key_index])
							array = array[key_index]["options"][key]
						
					starting_label_array = array
					break
		
		
		
		for index in range(same_label_begining_index, Global.stage_data["Dialogue_Log"][i]["index"]):
			if i == 1:
				print("break check")
				print(starting_label_array[index])
			var line = starting_label_array[index]
			#print("logging: ", line)
			if line["type"] == "SAY":
				var log_format := """
[p]%s[/p]
[indent][p]%s[/p][/indent]
[hr]""" % [layout_safe_name(line["character"]), line["text"]]
				Icon_menu_node.get_node("History_panel/RichTextLabel").append_text(log_format)
				dialogue_log.append({"character":line["character"], "text":line["text"]})
				#print("logging: ", dialogue_log)
				
	
	
	

func show_current_dialogue():
	#dialogue_index
	
	var count_index = 0

	
	# Clear the Characters array
	#Global.stage_data["Characters"].clear()
	
	if count_index != Global.stage_data["Dialogue"].back()["index"]:
		#count_index = Global.stage_data["Dialogue"]["index"]
		count_index = Global.stage_data["Dialogue"].back()["index"]
		
		#Global.stage_data["Dialogue"]["index"] = 0
		print(Global.stage_data)
		#count_index +=1
		#print("wwwwwwwwwww",count_index)
	
	Global.stage_data["Dialogue_Log"].append({"name":Global.stage_data["Dialogue"].back()["name"], \
	"type": Global.stage_data["Dialogue"].back()["type"], "index":Global.stage_data["Dialogue"].back()["index"], \
	"stack_depth":dialogue_log_stack_depth})
	
	while dialogue_route_enter == true:
		dialogue_route_enter = false
		#print("W ",dialogue_data_current)
		for i in range(count_index, dialogue_data_current.size()):

			#var parts = line.split(":", false, 2)
			var line = dialogue_data_current[i]
			print(line["type"])
			var character_node
			if line.has("character"):
				character_node= $Characters.get_node(line["character"]) 
			match line["type"]:
				
				#"CHARACTER":
					#pass
				"VISIBLE":
					character_node.visible = line["value"]
					
					add_or_update_saving_data(character_node)
				"POSITION":
					character_node.position = line["value"]
					add_or_update_saving_data(character_node)
				"SPRITE_FLIP":
					character_node.flip_h = line["value"]
					add_or_update_saving_data(character_node)
				"SPRITE_SCALE":
					character_node.scale = line["value"]
					add_or_update_saving_data(character_node)
				"SPRITE_ORDER":
					character_node.z_index = line["value"]
					add_or_update_saving_data(character_node)
				"TRANSITION":
					var transition_data = []
					match line["transition"]:
						"transition_move":
							$Characters.transition_move(character_node, line["values"]["position"], line["values"]["duration"])
							transition_data.append_array([line["values"]["position"], line["values"]["duration"]])
						"transition_move_shaking_loop":
							$Characters.transition_move_shaking_loop(character_node, line["values"]["duration"])
							transition_data.append_array([line["values"]["duration"]])
						"transition_rotate":
							$Characters.transition_rotate(character_node, line["values"]["rotation"], line["values"]["duration"])
							transition_data.append_array([line["values"]["rotation"], line["values"]["duration"]])
						"transition_scale":
							$Characters.transition_scale(character_node, line["values"]["scale"], line["values"]["duration"])
							transition_data.append_array([line["values"]["scale"], line["values"]["duration"]])
						"transition_scale_pulse_loop":
							$Characters.transition_scale_pulse_loop(character_node, line["values"]["scale"], line["values"]["duration"])
							transition_data.append_array([line["values"]["scale"], line["values"]["duration"]])
						"transition_scale_pulse_custome":
							$Characters.transition_sale_pulse_custome(character_node, line["values"]["scale"], line["values"]["duration"], line["values"]["interval"])
							transition_data.append_array([line["values"]["scale"], line["values"]["duration"], line["values"]["interval"]])
						
					if line["transition"].contains("loop"):
						update_saving_data_transition(character_node, line["transition"], transition_data)
				
				"ANIMATION":
					character_node.animation = line["anim"]
					var modulate = line["modulate"]
					
					character_node.modulate = Color(modulate)
					
					update_saving_data_animation(character_node, modulate)
					
				"CHOICES":
					dialogue_choice_pick_bool = true
					
					if dialogue_log.back()["character"] != " " and dialogue_log.back()["character"] != "":
						$NameBox.visible = true
						$NameBox/RichTextLabel.text = "[b]" + dialogue_log.back()["character"] + "[/b]"
						if dialogue_log.back()["character"] == "Camellia":
							$NameBox/RichTextLabel.text = "[b][outline_color=HOT_PINK]" + dialogue_log.back()["character"] + "[/outline_color][/b]"
						elif dialogue_log.back()["character"] == "Salvia":
							$NameBox/RichTextLabel.text = "[b][outline_color=purple]" + dialogue_log.back()["character"] + "[/outline_color][/b]"
							
					else:
						$NameBox.visible = false
					$DialogueBox/RichTextLabel.text = dialogue_log.back()["text"]
					#$DialogueBox.show_text(dialogue_log.back()["text"])
					
					
					var hbox := $ChoiceBoxContainer/CenterContainer/HBoxContainer
					for child in hbox.get_children():
						hbox.remove_child(child)
						child.queue_free()

					for option in line["options"]:
						var b := Button.new()
						b.text = option
						b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
						b.custom_minimum_size = Vector2(1750, 64)
						b.size_flags_vertical = Control.SIZE_SHRINK_CENTER
						#hbox.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
						
						
						#var font := load("res://fonts/MyFont.ttf")
						#b.add_theme_font_override("font", font)
						b.add_theme_font_size_override("font_size", 37)


						#b.pressed.connect(func(): _on_choice_selected(option))
						b.pressed.connect(_on_choice_selected.bind(option, line["options"][option]))

						hbox.add_child(b)

					# make sure container resizes correctly
					hbox.queue_sort()
					$ChoiceBoxContainer._buttons_checking()
					#$ChoiceBoxContainer._menu_pausing_toggle(true)
					
					await get_tree().process_frame
					await get_tree().process_frame
					$"../../../../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue".force_auto_save()
					
					await _Dialogue_choice_pick_
					#$ChoiceBoxContainer._menu_pausing_toggle(false)
					for child in hbox.get_children():
						hbox.remove_child(child)
						child.queue_free()
						
					dialogue_route_enter = true
					count_index = 0
					dialogue_choice_pick_bool = false
					break
					
				"SAY":
					if line["character"] != " " and line["character"] != "":
						$NameBox.visible = true
						$NameBox/RichTextLabel.text = "[b]" + line["character"] + "[/b]"
						if line["character"] == "Camellia":
							$NameBox/RichTextLabel.text = "[b][outline_color=HOT_PINK]" + line["character"] + "[/outline_color][/b]"
						elif line["character"] == "Salvia":
							$NameBox/RichTextLabel.text = "[b][outline_color=purple]" + line["character"] + "[/outline_color][/b]"
							
					else:
						$NameBox.visible = false
					#$DialogueBox/RichTextLabel.text = line["text"]
					$DialogueBox.show_text(line["text"])
					#print("wwwwwwwwwww",line["text"])
					dialogue_log.append({"character":line["character"], "text":line["text"]})
					var entry := """
[p]%s[/p]
[indent][p]%s[/p][/indent]
[hr]""" % [layout_safe_name(line["character"]), line["text"]]

					Icon_menu_node.get_node("History_panel/RichTextLabel").append_text(entry)
					
					if Icon_menu_node.skip_toggle == true:
						$DialogueBox.skip_text()
						
						$Skip_speed.start()
						await $Skip_speed.timeout
						
						if Icon_menu_node.skip_toggle == false:
							await _Dialogue_next_
						
					else:
						await _Dialogue_next_
						
					if $DialogueBox.typing_anim == true:
						$DialogueBox.skip_text()
						await _Dialogue_next_
					
				
				"UI_HIDE":
					$NameBox.visible=false
					$DialogueBox.transition_move_out()
					
					if Icon_menu_node.skip_toggle == true:
						$Skip_speed.start()
						await $Skip_speed.timeout
						
						if Icon_menu_node.skip_toggle == false:
							await _Dialogue_next_
						
					else:
						await _Dialogue_next_
				"UI_SHOW":
					$NameBox.visible=true
					await $DialogueBox.transition_move_in()
					#await _Dialogue_next_
					
				"ROUTE":
					
					#Global.stage_data["Dialogue"].clear()
					Global.stage_data["Dialogue"].append({"name":line["data"], "type": "Label", "index":0})
					dialogue_log_stack_depth += 1
					Global.stage_data["Dialogue_Log"].append({"name":Global.stage_data["Dialogue"].back()["name"], \
					"type": Global.stage_data["Dialogue"].back()["type"], "index":Global.stage_data["Dialogue"].back()["index"], \
					"stack_depth":dialogue_log_stack_depth})
					
					
					print("Route ",Global.stage_data["Dialogue"])
					dialogue_data_current = DialogueData.get(line["data"])
					
					
					dialogue_route_enter = true
					count_index = 0
					break
					
				"VARIABLE":
					#Global.set(line["name"], line["value"])

					if Global.stage_data["Variables"].has(line["name"]):
						Global.stage_data["Variables"][line["name"]] = line["value"]
					
				"CHECK_VARIABLE":
					#Global.set(line["name"], line["value"])
					#Global.set(line["options"])

					if Global.stage_data["Variables"].has(line["name"]):
						for path in line["options"]:
							if Global.stage_data["Variables"][line["name"]] == path:
								Global.stage_data["Dialogue"].append({"name":path, "type": "Check", "index":0})
								
								dialogue_log_stack_depth += 1
								Global.stage_data["Dialogue_Log"].append({"name":Global.stage_data["Dialogue"].back()["name"], \
								"type": Global.stage_data["Dialogue"].back()["type"], "index":Global.stage_data["Dialogue"].back()["index"], \
								"stack_depth":dialogue_log_stack_depth})
								
								print(Global.stage_data["Dialogue"])
								dialogue_data_current = line["options"][path]
								dialogue_route_enter = true
								count_index = 0
								break
					
					
				"SCENE":
					#_set_all_process(false)
					await TransitionScreen.fade_in()
					
					Global.stage_data = {
					"Characters": [{"name":"character_test", 
								"position":Vector2.ZERO, 
								"sprite_flip": false, 
								"sprite_scale": Vector2(1.0, 1.0), 
								"sprite_order": 0,
								"animation":["",""], 
								"transiton":["name","datas"]}, 
								{}],
					"Dialogue" : [{"name":"", "index":0}],
					"Variables" : {"cafe":0, "office":0},
					"Scene" : "Dialogue" #	"Dialogue" / "Minigame Cafe" / "Minigame Office" / "Minigame festival"
					}
					
					Global.loading_next_scene_path = line["scene"]
					get_tree().change_scene_to_file("res://scene/UI/Loading/loading_scene.tscn")
					return
					
					
				"AUTO_SAVE":
					$"../../../../PauseMenu_InGame_Dialogue/Options/Menus/SaveLoad_inDialogue".force_auto_save()
					
					
				"ENDING":
					Global.stage_data["Dialogue"].clear()
					print( Global.stage_data["Dialogue"])
					break
			if dialogue_route_enter == false:
				count_index +=1
				#Global.stage_data["Dialogue"]["index"] = count_index
				print(Global.stage_data["Dialogue"].back())
				Global.stage_data["Dialogue"].back()["index"] = count_index
				
				Global.stage_data["Dialogue_Log"].back()["index"] = count_index
				
				print("CONTINUE: ",Global.stage_data["Dialogue"])
		
		# for returning after a route
		if Global.stage_data["Dialogue"].size() > 1 and dialogue_route_enter == false: 
			
			
			
			Global.stage_data["Dialogue"].pop_back()
			print("2.5------------------")
			print(Global.stage_data["Dialogue"])
			
			await get_tree().process_frame
			
			
			#checking for main label type
			if Global.stage_data["Dialogue"].back()["type"] != "Label":
				
				for dict_index in range(Global.stage_data["Dialogue"].size()-1, 0-1, -1):
					print("in")
					if Global.stage_data["Dialogue"][dict_index]["type"] == "Label":
						var label_route = DialogueData.get(Global.stage_data["Dialogue"][dict_index]["name"]) 
						for return_dict_index in range(dict_index+1, Global.stage_data["Dialogue"].size()):
							var key =  Global.stage_data["Dialogue"][return_dict_index]["name"]
							var index = Global.stage_data["Dialogue"][dict_index]["index"]
							label_route = label_route[index]["options"][key]
							print("label_route ",label_route)
						#var array = label_route
						#var key
						#for return_dict_index in range(dict_index, Global.stage_data["Dialogue"].size()):
							#if  Global.stage_data["Dialogue"][return_dict_index]["stack_depth"] < Global.stage_data["Dialogue"].back()["stack_depth"]:
								#key = Global.stage_data["Dialogue_Log"][return_dict_index+1]["name"]
								#var key_index = int(Global.stage_data["Dialogue"][return_dict_index]["index"])
								#print("2------------------")
								#print(key)
								#print(key_index)
								#print("check the aray ",array[key_index])
								#array = array[key_index]["options"][key]
						
						dialogue_data_current = label_route
						
						break
			else:
				dialogue_data_current = DialogueData.get(Global.stage_data["Dialogue"].back()["name"])
			
			
			
			count_index = Global.stage_data["Dialogue"].back()["index"] + 1
			Global.stage_data["Dialogue"].back()["index"] = count_index
			print(Global.stage_data["Dialogue"])
			
			dialogue_log_stack_depth -= 1
			Global.stage_data["Dialogue_Log"].append({"name":Global.stage_data["Dialogue"].back()["name"], \
			"type": Global.stage_data["Dialogue"].back()["type"], "index":Global.stage_data["Dialogue"].back()["index"], \
			"stack_depth":dialogue_log_stack_depth})
			
			print("go back")
			print(dialogue_data_current)
			if dialogue_data_current.size() < count_index:
				print("New Ready line: ",dialogue_data_current[count_index])
			#print( Global.stage_data["Dialogue"])
			dialogue_route_enter = true
		
	Global.stage_data["Dialogue"].pop_back()
	#print( Global.stage_data["Dialogue"])
	_set_all_process(false)
	
#----------------Button
func _on_choice_selected(title, option):

	Global.stage_data["Dialogue"].append({"name":title, "type": "Choice", "index":0})
	
	dialogue_log_stack_depth += 1
	Global.stage_data["Dialogue_Log"].append({"name":Global.stage_data["Dialogue"].back()["name"], \
	"type": Global.stage_data["Dialogue"].back()["type"], "index":Global.stage_data["Dialogue"].back()["index"], \
	"stack_depth":dialogue_log_stack_depth})
	
	print("Choice: ",Global.stage_data["Dialogue"])
	#print(Global.stage_data["Dialogue"])
	dialogue_data_current = option
	emit_signal("_Dialogue_choice_pick_")
	$ChoiceBoxContainer._menu_pausing_toggle(true)
	
	
#----------------------------------------updating data
func add_or_update_saving_data(node: AnimatedSprite2D):
	for c in Global.stage_data["Characters"]:
		if c.get("name") == String(node.name):
			c["position"] = node.position
			c["sprite_flip"] = node.flip_h
			c["sprite_scale"] = node.scale
			c["sprite_order"] = node.z_index
			return
			
	# add new
	Global.stage_data["Characters"].append({
		"name": node.name,
		"position": node.position,
		"sprite_flip": node.flip_h, 
		"sprite_scale": node.scale, 
		"sprite_order": node.z_index,
		"animation": [],
		"transition": []
	})
	
	print(Global.stage_data["Characters"])
		
func update_saving_data_animation(node: AnimatedSprite2D, modulate: String):
	for c in Global.stage_data["Characters"]:
		if c.get("name") == String(node.name):
			# update existing
			c["animation"] = [node.animation, modulate]
			#print("already in")
			return
			
	
	print(Global.stage_data["Characters"])
	
func update_saving_data_transition(node: AnimatedSprite2D, transition: String, datas: Array):
	for c in Global.stage_data["Characters"]:
		if c.get("name") == String(node.name):
			# update existing
			c["transition"] = [transition, datas]
			#print("already in")
			print(Global.stage_data["Characters"])
			return
			
	
#----------------------------------------


#---------------------------------------- loading Data
func loading_data_sprite():
	#await get_tree().process_frame
	for c in Global.stage_data["Characters"]:
		var character_node= $Characters.get_node(c["name"])
		character_node.visible = true
		
		character_node.position = string_to_vector2(c["position"])
		
		character_node.flip_h = c["sprite_flip"]
		
		character_node.scale = string_to_vector2(c["sprite_scale"])
		character_node.z_index = c["sprite_order"]
		
		await get_tree().process_frame
		character_node.animation = c["animation"][0]
		character_node.modulate = Color(c["animation"][1])
		
		if c["transition"] != []:
			match c["transition"][0]:
				"transition_move":
					$Characters.transition_move(character_node, Vector2( c["transition"][1][0], c["transition"][1][1]), float(c["transition"][1][2]))
				"transition_move_shaking":
					$Characters.transition_move_shaking(character_node, float(c["transition"][1][0]))
				"transition_rotate":
					$Characters.transition_rotate(character_node, float(c["transition"][1][0]), float(c["transition"][1][1]))
				"transition_scale":
					$Characters.transition_scale(character_node, Vector2( float(c["transition"][1][0]), float(c["transition"][1][1])), float(c["transition"][1][2]))
				"transition_scale_pulse":
					$Characters.transition_scale_pulse(character_node, Vector2( float(c["transition"][1][0]), float(c["transition"][1][1])), float(c["transition"][1][2]))
				"transition_scale_pulse_custome":
					$Characters.transition_scale_pulse_custome(character_node, Vector2( float(c["transition"][1][0]), float(c["transition"][1][1])), float(c["transition"][1][2]), int(c["transition"][1][3]))

#---------------------------------------- Extra function
func string_to_vector2(str) -> Vector2:
	if str is not Vector2:
		var cleaned = str.lstrip("()")  # remove "(" and ")"
		var parts = cleaned.split(",")
		
		if parts.size() != 2:
			return Vector2.ZERO
			
		return Vector2(parts[0].to_float(), parts[1].to_float())
	else:
		return str
		

func layout_safe_name(inp_name: String):
	var safe_name = ""
	#if name.length() < 12:
		#var spaces = 12- name.length()
		#safe_name = name + " ".repeat(spaces) + ":"
	safe_name = inp_name + ":"
	#else:
		#safe_name = name.substr(0, 12 - 3) + "…" + ":"
	return safe_name

#----------------------------------------

func _update_dialogue():
	pass

func _set_all_process(x:bool):
	set_process(x)
	set_physics_process(x)
	set_process_input(x)

	#dialogue_index = 0

	if x == false:
		$NameBox.visible=x
		$DialogueBox.transition_move_out()
		for i in range(60 * 1): 
			while get_tree().paused:
				await get_tree().process_frame 
			await get_tree().physics_frame
		visible=x
		reset_all_anim_sprite()
		get_parent().emit_signal("_Dialogue_done_")
		#get_parent().event_dialogue_bool = false
		
	else:
		$NameBox.visible=x
		visible=x
		reset_all_anim_sprite()
		await $DialogueBox.transition_move_in()
		#get_parent().event_dialogue_bool = true

func reset_all_anim_sprite():
	$Characters/Salvia.animation = 'default'
	$Characters/Camellia.animation = 'default'
	$Characters/character_test.animation = 'default'

	
	$Characters/Salvia.z_index = 0
	$Characters/Camellia.z_index = 0
	$Characters/character_test.z_index = 0


func visible_dialogues_UI_toggle(x: bool):
	$DialogueBox.visible = x
	$NameBox.visible = x
	$ChoiceBoxContainer.visible = x
