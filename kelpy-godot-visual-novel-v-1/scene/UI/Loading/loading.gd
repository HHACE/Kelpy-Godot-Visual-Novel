extends CanvasLayer



var progress := []
var is_loading := false

func goto_scene(path: String):
	if is_loading:
		print("Already loading a scene...")
		return
	is_loading = true
	Global.loading_next_scene_path = path
	progress = []
	ResourceLoader.load_threaded_request(Global.loading_next_scene_path)
	set_process(true)
	print("Started loading: ", path)

func _reset():
	await TransitionScreen.fade_out()
	is_loading = false
	Global.loading_next_scene_path = ""
	set_process(false)

func _ready() -> void:
	#_reset()
	goto_scene(Global.loading_next_scene_path)

func _process(delta):
	if !is_loading or Global.loading_next_scene_path == "":
		return

	var status = ResourceLoader.load_threaded_get_status(Global.loading_next_scene_path, progress)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print("Loading: ", int(progress[0] * 100), "%")
			$ProgressBar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene = ResourceLoader.load_threaded_get(Global.loading_next_scene_path)
			$ProgressBar.value = progress[0] * 100
			if new_scene:
				print("Loaded scene: ", Global.loading_next_scene_path)
				get_tree().change_scene_to_packed(new_scene)
			else:
				print("Error: failed to retrieve loaded scene")
			_reset()

		ResourceLoader.THREAD_LOAD_FAILED:
			print("Failed to load: ", Global.loading_next_scene_path)
			_reset()
