extends Node2D

#--------------SHARE SIGNAL
signal _Setting_Dialogue_Changed_


var loading_next_scene_path : String = ""
#--------------VARIABLES

#var user_control_setting
#setting_volumns

var user_graphic_setting = {
	"window_mode": "Window", #Window / Fullscreen 
	"vsync": true,
}

var user_dialogue_setting = {
	#default setting
	"txt_speed": 40.0, # 5- 70 , 5
	"txt_size": 47.0, # 32, 37, 42, 47
	"auto_speed": 3.0 # 0 - 5s
}


var stage_data = {
	#"Characters": [{"name":"character_test", 
					#"position":Vector2.ZERO, 
					#"sprite_flip": false, 
					#"sprite_scale": Vector2(1.0, 1.0), 
					#"sprite_order": 0,
					#"animation":["",""], 
					#"transiton":["name","datas"]}, 
					#{}],
	#"Dialogue" : [{"name":"dialogue_guide_v2", "index":0}],
	#"Variables" : {"cafe":0, "office":0},
	#"Scene" : "Dialogue" #	"Dialogue" / "Minigame Cafe" / "Minigame Office" / "Minigame festival"

	"Characters": [{"name": "character_test", 
					"position": Vector2(529.0, 315.0), 
					"sprite_flip": false, 
					"sprite_scale": Vector2(1.0, 1.0), 
					"sprite_order": 0,
					"animation":["default", "787878"], 
					"transition":["",[]]
					}],
	
	"Dialogue" : [
					{"name":"test_label", "type":"Label", "index":0}
				],
	"Dialogue_Log":[
		#{
		#"character":"", "text": ""
		#{"name":"dialogue_guide_v2", "type":"", "index":0, "stack_depth":0} #type: label, choice, check
	#}
	],
	
	"Variables" : {"chapter_title": "Winter, December 31st", "cafe":0, "office":0, "score1":0},
	"Scene" : "Dialogue" #	"Dialogue" / "Minigame Cafe" / "Minigame Office" / "Minigame festival"


}


#----------------



#----------------
func VN_saving():
	pass
	
func VN_loading():
	pass
