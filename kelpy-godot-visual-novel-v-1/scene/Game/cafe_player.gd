extends CharacterBody3D

@export var look_sensitivity : float = 0.006
@export var jump_velocity := 6.0
@export var walk_speed := 7.0
@export var sprint_speed := walk_speed * 2

@onready var raycast = $Head/Camera3D/RayCast3D
@onready var hand = $Head/Camera3D/Hand/MeshInstance3D
#func _ready() -> void:
	#for child in $WorldModel.find_children("*", "VisualInstance3D"):
		#child.set_layer_mask_value(1, false)
		#child.set_layer_mask_value(2, true)

#func _process(delta: float) -> void:
	#print(position)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			#if camera_style == CameraStyle.THIRD_PERSON_FREE_LOOK:
				# Rotate the camera orbit rather than the player with mouse in free look mode
				#$Head/Camera3D.rotate_y(-event.relative.x * look_sensitivity)
			#else:
				#$Head/Camera3D.rotation.y = 0
				#rotate_y(-event.relative.x * look_sensitivity)
			rotate_y(-event.relative.x * look_sensitivity)
			# First person look up and down
			$Head/Camera3D.rotate_x(-event.relative.y * look_sensitivity)
			$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			# Third person look up and down
			#%ThirdPersonOrbitCamPitch.rotation.x = %Camera3D.rotation.x
	
	#if event is InputEventMouseButton and event.is_pressed():
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#noclip_speed_mult = min(100.0, noclip_speed_mult * 1.1)
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#noclip_speed_mult = max(0.1, noclip_speed_mult * 0.9)



#--------------Movement
var wish_dir := Vector3.ZERO

func _handle_air_physics(delta) -> void:
	self.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
func _handle_ground_physics(delta) -> void:
	self.velocity.x = wish_dir.x * get_move_speed()
	self.velocity.z = wish_dir.z * get_move_speed()
	
func get_move_speed() -> float:
	return sprint_speed if Input.is_action_pressed("cafe_control_sprint") else walk_speed
	
func _physics_process(delta):

	var input_dir = Input.get_vector("cafe_control_left", "cafe_control_right", "cafe_control_up", "cafe_control_down")
	wish_dir = self.global_transform.basis * Vector3(input_dir.x, 0., input_dir.y)
	if is_on_floor():
		if Input.is_action_just_pressed("cafe_control_jump"):
			self.velocity.y = jump_velocity
		_handle_ground_physics(delta)
	else:
		_handle_air_physics(delta)
		
	move_and_slide()
	
	
var held_object: RigidBody3D = null
func _process(delta: float) -> void:
	if held_object:
		held_object.global_transform = hand.global_transform

	if Input.is_action_just_pressed("cafe_control_interact"):
		if held_object:
			drop_object()
		else:
			try_pickup()


func try_pickup():
	if raycast.is_colliding():
		var obj = raycast.get_collider()
		if obj and obj.is_in_group("pick_up_able"):
			print(obj)
			held_object = obj
			held_object.freeze = true
			held_object.collision_layer = 2
			held_object.reparent(hand)
			held_object.transform = Transform3D.IDENTITY

func drop_object():
	if held_object:
		held_object.reparent(get_tree().current_scene)
		held_object.collision_layer = 1
		held_object.linear_velocity = Vector3(0.1, 3, 0.1)
		held_object.freeze = false
		held_object = null
