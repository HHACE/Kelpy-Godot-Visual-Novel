extends CanvasLayer

signal _PopUp_Message_pressed_(value: String)

#------------------popup message
func setup_popup_message(text: String, button_number: int, custome_button_title: Array):
	visible = true
	var text1 = "Are you sure you want to overwrite this save?"
	var text5 = "Can't save to automatic save slot."
	var text2 = "Loading will lose unsaved progress\nAre you sure you want to load?"
	var text3 = "Are you sure you want to return to the main menu?\nThis will lose unsaved progress."
	var text4 = "Are you sure you want to quit?"
	$RichTextLabel.text = text
	
	for child in $Buttons.get_children():
		child.visible = false
		
	match button_number:
		1:
			$Buttons/Single.visible = true
			if !custome_button_title.is_empty():
				$Buttons/Single.text = custome_button_title[0]
		2:
			$Buttons/No.visible = true
			$Buttons/Yes.visible = true
			if !custome_button_title.is_empty():
				$Buttons/No.text = custome_button_title[0]
				$Buttons/Yes.text = custome_button_title[1]



func _on_popup_x_button_pressed(x: String) -> void:
	visible = false
	emit_signal("_PopUp_Message_pressed_",x)

#------------------/popup message
