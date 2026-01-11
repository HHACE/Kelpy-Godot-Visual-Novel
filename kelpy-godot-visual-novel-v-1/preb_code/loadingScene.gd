extends CanvasLayer

func _ready() -> void:
	randomize()  
	#get_parent().loading_bool = true
	#visible= true
	#$chibi_misco.visible = true
	#$black.visible = true
	#$transition.visible = false
	#get_tree().paused = true
	#for i in range(60): 
		##while get_tree().paused or Engine.time_scale != 1.0:
			##await get_tree().process_frame 
		#await get_tree().physics_frame
	#get_tree().paused = false
	#$chibi_misco.visible = false
	#$black.visible = false
	#$transition.visible = true
	#_play_transition()
	##visible= false
	#get_parent().loading_bool = false

func _load_game_stage():
	get_parent().loading_bool = true
	visible= true
	$chibi.visible = true
	$black.visible = true
	$transition.visible = false
	get_tree().paused = true
	for i in range(60): 
		#while get_tree().paused or Engine.time_scale != 1.0:
			#await get_tree().process_frame 
		await get_tree().physics_frame
	get_tree().paused = false
	$chibi.visible = false
	$black.visible = false
	$transition.visible = true
	_play_transition_out_random()
	#visible= false
	#get_parent().loading_bool = false
	
func _load_next_scene():
	visible= true
	$chibi.visible = true
	$black.visible = true
	$transition.visible = false
	get_tree().paused = true
	for i in range(10): 
		#while get_tree().paused or Engine.time_scale != 1.0:
			#await get_tree().process_frame 
		await get_tree().physics_frame
	get_tree().paused = false
	$chibi.visible = false
	$black.visible = false
	$transition.visible = true
	_play_transition_out_random()

	
func _move_to_next_scene(scene_name:String):
	visible= true
	$chibi.visible = false
	$black.visible = false
	$transition.visible = true
	_play_transition_in_random()
	await $transition/AnimationPlayer.animation_finished
	await get_tree().process_frame

	get_tree().change_scene_to_file(scene_name)

func _play_transition_out_random():
	var transitions = [
		"transition_out_black_1_2_top",
		"transition_out_black_1_2_bottom",
		"transition_out_black_1_2_left",
		"transition_out_black_1_2_right"
	]

	var random_anim = transitions[randi() % transitions.size()]
	$transition/AnimationPlayer.play(random_anim)
	
func _play_transition_in_random():
	var transitions = [
		"transition_in_black_1_2_top",
		"transition_in_black_1_2_bottom",
		"transition_in_black_1_2_left",
		"transition_in_black_1_2_right"
	]

	var random_anim = transitions[randi() % transitions.size()]
	$transition/AnimationPlayer.play(random_anim)
