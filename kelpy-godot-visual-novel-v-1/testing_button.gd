extends Node2D

var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600,900),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600)
}

func _ready() -> void:
	for i in resolutions:
		$OptionButton.add_item(i)

func _on_button_pressed() -> void:
	print("pressed")


func _on_h_slider_value_changed(value: float) -> void:
	print("editing: ", $HSlider.value)

func _on_h_slider_mouse_exited() -> void:
	$HSlider.release_focus()

	
var ob_popup_is_open := false  # track dropdown state manually
var select_index : = 0
@onready var ob = $OptionButton
func _process(_delta):

	if ob.has_focus():
		# Open the dropdown
		if Input.is_action_just_pressed("UI_control_confirm"):
			if ob_popup_is_open == false:
				ob_popup_is_open = true
				ob.show_popup()
			else:
				ob_popup_is_open = false
				ob.select(select_index)
		
		# Directly select first/next/prev item
		if Input.is_action_just_pressed("UI_control_down") and ob_popup_is_open == true:
			select_index = clamp(ob.get_selected() + 1, 0, ob.get_item_count() - 1)
			print(select_index)
			ob.select(select_index)

		if Input.is_action_just_pressed("UI_control_up") and ob_popup_is_open == true:
			select_index = clamp(ob.get_selected() - 1, 0, ob.get_item_count() - 1)
			ob.select(select_index)
