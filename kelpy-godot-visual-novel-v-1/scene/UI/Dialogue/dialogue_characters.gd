extends Node2D

#var active_tween : Tween = null

var looping = false

var tween_done := false
var tween_playing := false

func _on_tween_finished(tween):
	#print(" was pressed")
	tween_done = true

func _ready() -> void:
	$"..".connect("_Dialogue_next_", Callable(self, "_on_dialogue_next"))
	$"..".connect("_Dialogue_choice_pick_", Callable(self, "_on_dialogue_next"))


	
func _on_dialogue_next():
	looping = false
	tween_done = true
	tween_playing = false
	#if active_tween and active_tween.is_valid():
		#active_tween.kill()
	
	await get_tree().process_frame
	tween_done = false

func _process(delta: float) -> void:
	pass
#---------------------------------------------------------

func transition_move(character:AnimatedSprite2D, move_to_position: Vector2, duration: float):
	await get_tree().process_frame
	var tween = get_tree().create_tween()
	if tween and tween.is_valid():
		tween.kill()
		tween = get_tree().create_tween()
		
	#tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property(character, "position", move_to_position, duration)
	
	tween_done = tween.finished.connect(_on_tween_finished.bind(tween))
	await get_tree().process_frame
	while tween_done == false:
			await get_tree().process_frame
			
	tween.kill()
	character.position = move_to_position


func transition_rotate(character:AnimatedSprite2D, rotate_to: float, duration: float):
	await get_tree().process_frame
	var tween = get_tree().create_tween()
	if tween and tween.is_valid():
		tween.kill()
		tween = get_tree().create_tween()
		
	#tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(character, "rotation_degrees", rotate_to, duration)
	
	tween_done = tween.finished.connect(_on_tween_finished.bind(tween))
	await get_tree().process_frame
	while tween_done == false:
			await get_tree().process_frame
			
	tween.kill()
	character.rotation_degrees = rotate_to



func transition_scale(character:AnimatedSprite2D, scale_to: Vector2, duration: float):
	await get_tree().process_frame
	var tween = get_tree().create_tween()
	if tween and tween.is_valid():
		tween.kill()
		tween = get_tree().create_tween()
		
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(character, "scale", scale_to, duration)
	
	tween_done = tween.finished.connect(_on_tween_finished.bind(tween))
	await get_tree().process_frame
	while tween_done == false:
			await get_tree().process_frame
			
	tween.kill()
	character.scale = scale_to


func transition_scale_pulse_loop(character: AnimatedSprite2D, scale_to: Vector2, duration: float) -> void:
	await get_tree().process_frame
	looping = true
	
	while looping:
		
		var tween : Tween = null
		if tween and tween.is_valid():
			tween.kill()
			tween = get_tree().create_tween()
		
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_SINE)

		tween.tween_property(character, "scale", scale_to, duration)
		tween.tween_property(character, "scale", Vector2.ONE, duration)

		tween_done = tween.finished.connect(_on_tween_finished.bind(tween))

		await get_tree().process_frame
		while tween_done == false and looping:
			await get_tree().process_frame
			
		if not looping:
			if tween:
				tween.kill()
			break

	# After loop ends, reset immediately
	character.scale = Vector2(1, 1)
	
func transition_scale_pulse_custome(character: AnimatedSprite2D, scale_to: Vector2, duration: float, interval: int) -> void:
	var counter = 0
	character.scale = Vector2(1, 1)
	
	await get_tree().process_frame
	tween_playing = true
	
	while counter < interval:
		counter += 1
		
		var tween : Tween = null
		if tween and tween.is_valid():
			tween.kill()
			tween = get_tree().create_tween()
		
		tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_property(character, "scale", scale_to, duration)
		tween.tween_property(character, "scale", Vector2.ONE, duration)

		tween_done = tween.finished.connect(_on_tween_finished.bind(tween))

		await get_tree().process_frame
		while tween_done == false :
			await get_tree().process_frame
			
		if tween_playing == false:
			if tween:
				tween.kill()
			break

	character.scale = Vector2(1, 1)


func transition_move_shaking(character:AnimatedSprite2D, duration: float, interval: int):
	await get_tree().process_frame
	var tween = get_tree().create_tween()
	var current_position = character.position
	var counter = 0
	tween_playing = true
	
	while counter < interval:
		counter += 1
		if tween and tween.is_valid():
			tween.kill()
			tween = get_tree().create_tween()
			
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(character, "position", Vector2(current_position.x + 10, current_position.y), duration)
		tween.tween_property(character, "position", Vector2(current_position.x - 10, current_position.y), duration)
		
		
		tween_done = tween.finished.connect(_on_tween_finished.bind(tween))
		await get_tree().process_frame
		while tween_done == false:
				await get_tree().process_frame
				
		if tween_playing == false:
			if tween:
				tween.kill()
			break
			
	character.position = current_position


func transition_move_shaking_loop(character:AnimatedSprite2D, duration: float):
	await get_tree().process_frame
	looping = true
	var current_position = character.position
	while looping:
		var tween = get_tree().create_tween()
		if tween and tween.is_valid():
			tween.kill()
			tween = get_tree().create_tween()
			
		#tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_IN_OUT)
		
		tween.tween_property(character, "position", Vector2(current_position.x + 10, current_position.y), duration)
		tween.tween_property(character, "position", Vector2(current_position.x - 10, current_position.y), duration)
		
		tween_done = tween.finished.connect(_on_tween_finished.bind(tween))
		await get_tree().process_frame
		while tween_done == false:
				await get_tree().process_frame
				
		if not looping:
			if tween:
				tween.kill()
			break
	character.position = current_position
