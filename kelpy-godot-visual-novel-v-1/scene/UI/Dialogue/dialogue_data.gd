extends Node

var dialogue_guide = [
	"VISIBLE: character_test, true",
	
	"ANIMATION: character_test, default, dark",
	"ANIMATION: character_test, talk, normal",
	
	"POSITION: character_test, 529.0, 315.0",
	
	#"TRANSITION: character_test, transition_move, 829.0, 315.0, 2",
	#"TRANSITION: character_test, transition_scale, 2.0, 2.0, 2",
	#"TRANSITION: character_test, transition_scale_pulse_loop, 2.0, 2.0, 2",
	#"TRANSITION: character_test, transition_scale_pulse_custome, 2.0, 2.0, 2, 10",
	#"TRANSITION: character_test, transition_rotate, 90.0, 2",
	#"TRANSITION: character_test, transition_move_shaking_loop, 0.05",
	
	
	#"SPRITE_FLIP: character_test, false",
	#"SPRITE_SCALE: character_test, 1.0, 1.0",
	#"SPRITE_ORDER: character_test, 0",
	
	
	"-name: character_test",
	"-:Hi?",
	#"TRANSITION: character_test, transition_scale_pulse_custome, 2.0, 2.0, 2, 10",
	"ANIMATION: character_test, default, dark",
	#"TRANSITION: character_test, transition_move, 529.0, 315.0, 2",
	
	
	#"TRANSITION: character_test, transition_scale_pulse_loop, 2.0, 2.0, 2",
	"-: A",
	#"TRANSITION: character_test, transition_rotate, 0.0, 2",
	#"TRANSITION: character_test, transition_scale, 1.0, 1.0, 2",
	
	#"Choices:" : {
		#"choice 1": "",
		#"choice 2": "",
		#"choice 3": "",
	#},
	
	
	"-: ",
]

var dialogue_guide_v2 = [
	{ "type": "VISIBLE", "character": "character_test", "value": true },
	{ "type": "ANIMATION", "character": "character_test", "anim": "talk", "modulate": "ffffff" },#787878 = dark
	{ "type": "POSITION", "character": "character_test", "value":Vector2(529.0, 315.0 )},
	
	{ "type": "SAY", "character": "character_test", "text": "1" },
	
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move", 
		#"values":{"position":Vector2(829.0,315.0), "duration":2}},
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_scale", 
		#"values":{"scale":Vector2(2.0,2.0), "duration":2}},
	{ "type": "TRANSITION", "character": "character_test", "transition": "transition_scale_pulse_loop", 
		"values":{"scale":Vector2(2.0,2.0), "duration":2}},
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_scale_pulse_custome", 
		#"values":{"scale":Vector2(2.0,2.0), "duration":2, "interval":10}},
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_rotate", 
		#"values":{"rotation":90.0, "duration":2}},
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move_shaking", 
		#"values":{"duration":0.05, "interval":6}},
	#{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move_shaking_loop", 
		#"values":{"duration":0.05}},
		
	#{ "type": "SPRITE_FLIP", "character": "character_test", "value": true },
	#{ "type": "SPRITE_SCALE", "character": "character_test", "value": Vector2(1.0, 1.0) },
	#{ "type": "SPRITE_ORDER", "character": "character_test", "value": 0 },
	{
		"type": "CHOICES", "options": {
			"choice 11": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 1" },
						{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move", 
							"values":{"position":Vector2(829.0,315.0), "duration":2}},
						{ "type": "SAY", "character": "character_test", "text": "bye 1" },
						{ "type": "VARIABLE", "name": "score1", "value": 1000 },
						#{ "type": "ENDING" },
						],
			"choice 2": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 2" },
						{ "type": "VARIABLE", "name": "score1", "value": 2000 },
						#{ "type": "SCENE", "scene": "res://scene/UI/Menus/MainMenu.tscn"},
						],
			"choice\n3": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 3" },
						{ "type": "VARIABLE", "name": "score1", "value": 3000 },
						],
		}
	},

	{ "type": "SAY", "character": "character_test", "text": "2" },

	{ "type": "SAY", "character": "character_test", "text": "3" },
	{ "type": "ANIMATION", "character": "character_test", "anim": "default", "modulate": "787878" },#787878 = dark
	
	{
		"type": "CHECK_VARIABLE", "name": "score1", "options": {
			0.0: [
						{ "type": "SAY", "character": "character_test", "text": "Hi 1" },
						{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move", 
							"values":{"position":Vector2(829.0,315.0), "duration":2}},
						{ "type": "SAY", "character": "character_test", "text": "bye 1" },
						{ "type": "VARIABLE", "name": "score1", "value": 1000 },
						{ "type": "ENDING" },
						],
			1000.0: [
						{ "type": "SAY", "character": "character_test", "text": "Hi 2" },
						{ "type": "VARIABLE", "name": "score1", "value": 2000 },
						{ "type": "SCENE", "scene": "res://scene/UI/Menus/MainMenu.tscn"},
						],
			2000.0: [
						{ "type": "SAY", "character": "character_test", "text": "Hi 3" },
						{ "type": "VARIABLE", "name": "score1", "value": 3000 },
						],
		}
	},
]



var dialogue_loading_test_v1 =[
	"VISIBLE: character_test, true",
	"POSITION: character_test, 529.0, 315.0",
	"ANIMATION: character_test, default, dark",
	"-:?",
	
	"ANIMATION: character_test, talk, normal",
	"-:Hi",
	"-:The name TEST",
	
	"ANIMATION: character_test, default, dark",
	"-:...",
]

var label_test_1 = [
	{ "type": "SAY", "character": "character_test", "text": "Label 1" },
]
var label_test_2 = [
	{ "type": "SAY", "character": "character_test", "text": "Label 2" },
	{ "type": "SAY", "character": "character_test", "text": "Label 22" },
]
var label_test_3 = [
	{ "type": "SAY", "character": "character_test", "text": "Label 3" },
	{
							"type": "CHOICES", "options": {
								"choice a": [
											{ "type": "SAY", "character": "character_test", "text": "Hi a" },
											],
								"choice b": [
											{ "type": "SAY", "character": "character_test", "text": "Hi b" },
											],
								"choice c": [
											{ "type": "SAY", "character": "character_test", "text": "Hi c" },
											],
							}
						},
						
	{ "type": "AUTO_SAVE"},
	{ "type": "SAY", "character": "character_test", "text": "Label 3" },
]
var test_label = [	
	{ "type": "VARIABLE", "name": "chapter_title", "value": "Winter, December Label_test" },
	{ "type": "SAY", "character": "character_test", "text": "LABEL TESTING" },
	{
		"type": "CHOICES", "options": {
			"choice 1": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 1" },
						{ "type": "SAY", "character": "character_test", "text": "Hi 1 continue" },
						#{ "type": "ROUTE", "data": "label_test_1"},
						{
							"type": "CHOICES", "options": {
								"choice 111": [
											{ "type": "SAY", "character": "character_test", "text": "Hi 111" },
											],
								"choice 222": [
											{ "type": "SAY", "character": "character_test", "text": "Hi 222" },
											],
								"choice\n333": [
											{ "type": "SAY", "character": "character_test", "text": "Hi 333" },
											],
							}
						},
						{ "type": "SAY", "character": "character_test", "text": "Hi 1 continue" },
						{ "type": "SAY", "character": "character_test", "text": "Hi 11 continue" },
						],
			"choice 22": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 2" },
						{ "type": "ROUTE", "data": "label_test_2"},
						],
			"choice\n3": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 3" },
						{ "type": "ROUTE", "data": "label_test_3"},
						{ "type": "SAY", "character": "character_test", "text": "bye 3" },
						],
		}
	},
	{ "type": "SAY", "character": "", "text": "FINISH LABEL 1" },
	

						
	{ "type": "SAY", "character": " ", "text": "FINISH LABEL TESTING" },
	]
	
var test_data_v1 = [
	"POSITION: character1, 264.0, 800.0",
	"ANIMATION: character1, default, normal",
	"TRANSITION: character1, transition_move, 264.0, 264.0",
	
	"POSITION: character2, 1114.0, 800.0",
	"ANIMATION: character2, default, dark",
	"TRANSITION: character2, transition_move, 1114.0, 290.0",
	
	"-:test",

	"ANIMATION: character1, default, dark",
	"ANIMATION: character2, default, normal",

	
	"-:You've been tested",
	
	"TRANSITION: character1, transition_move, 264.0, 800.0",
	"TRANSITION: character2, transition_move, 1114.0, 800.0",
]


var scene_day_test = [
	{ "type": "SAY", "character": "aaaaaaaaaaa", 
	"text": "...and… asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas  asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdasasdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "b", 
	"text": "1 asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "ccccccccccccccccccccccccc", 
	"text": "2 asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "2 asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "2 asdasdasdasdasdasdasdasdas" 
	},
	{
		"type": "CHOICES", "options": {
			"choice 1": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 1" },
						{ "type": "TRANSITION", "character": "character_test", "transition": "transition_move", 
							"values":{"position":Vector2(829.0,315.0), "duration":2}},
						{ "type": "SAY", "character": "character_test", "text": "bye 1" },
						
						],
			"choice 22": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 2" },
						{ "type": "VARIABLE", "name": "score1", "value": 2000 },
						{ "type": "SCENE", "scene": "res://scene/UI/Menus/MainMenu.tscn"},
						],
			"choice\n3": [
						{ "type": "SAY", "character": "character_test", "text": "Hi 3" },
						{ "type": "VARIABLE", "name": "score1", "value": 3000 },
						],
		}
	},
	{ "type": "SAY", "character": "", 
	"text": "3 asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "", 
	"text": "4 asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "", 
	"text": "5 asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas" 
	},
	{ "type": "SAY", "character": "", 
	"text": "6 asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas" 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "SAY", "character": " ", 
	"text": "ENDING asdasdasdasdasdasdasdasdas asdasdasdasdasdasdasdasdas"
	}
]

var scene_day_0 = [
	{ "type": "SAY", "character": "", 
	"text": "" 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "SAY", "character": " ", 
	"text": "ENDING"
	}
]

var scene_day_1 = [
	{ "type": "SAY", "character": " ", 
	"text": " A very grumpy woman trudges down the street at night, her mood as heavy as the shadows around her." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Stupid client, stupid paper, stupid work, stupid –me!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I knew I shouldn’t have agreed to them, but why did I!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Grrrr”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“How long did I endure this life… maybe too long”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But what choice do I have? I moved out to work—I can’t just say no anymore...”" 
	},
	
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I don’t even know what I want anymore...”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "A sweet scent from a nearby shop catches her attention" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What a nice aroma”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But Café at this hour? I don’t know if I should”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“It does look nice inside“" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Nicer than my cheap apartment...”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As Salvia peers through the café window, her eyes land on the woman behind the counter—a petite figure with soft pink hair and a gentle, closed-eyed smile, quietly polishing a glass." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia’s heart skips, her steps coming to a halt." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Wow...)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(She’s so beautiful, like she coming straight out of my dreams)" 
	},
	
	{ "type": "SAY", "character": "Salvia", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "”-M-Maybe a cup wouldn’t hurt.”" 
	},
	#----------------Camellia’s perspective:
	{ "type": "SAY", "character": " ", 
	"text": "Inside the café, the bell chimes as the door opens. A woman in a dark blue suit steps in, her posture slouched, exhaustion written plainly across her face." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(She must have had a tough day…)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Welcome. What can I get for you, dear customer?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Uh, hi… I want a drink, but at this hour, I don’t really know what to choose.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Is that so?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s quite cold outside. Perhaps something warm?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“That… sounds good.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Coming right up.”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Enjoy.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "After a sip of the perfectly prepared drink, Salvia feels her tension slowly melt away." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“So warm… so sweet ”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia watches quietly, smiling softly." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia catches sight of Camellia’s smile and feels her cheeks warm." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(She’s so pretty…)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Is something wrong?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“O-Oh—no, no, it’s nothing!”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia says, quickly hiding her face." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You seem tired. If there’s anything I can help with, I’d be more than happy to.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(She’s so modest… I can’t believe she’s real.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“It’s nothing serious. Just work… and life. I’ve been feeling a bit lost.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Lost… I see.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“There’s something I’ve come to understand… and I’d like to share it, if that’s alright.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Sure…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Lost… tell me, Miss, have you ever wondered why loneliness feels so cold and heavy like a winter night?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia gently shakes her head." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s the weight of what one carries alone… and the quiet longing for warmth.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“A heart burdened and untouched eventually forgets how to stay warm.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Is that so…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“And Miss, do you like your drink?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“The cup you’re holding contains cocoa beans blended with warm milk, a recipe meant to cradle the heart. I’m glad it found its way to yours.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“My… heart…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m afraid I can’t help much beyond that. But since this is your first visit, this cup is on the house.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Eh? I can’t accept that-it’s such a lovely drink, I really should pay-”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hm”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“How about this instead? Let’s make a promise, whenever the world feels heavy and the air turns cold, this place will be here, waiting to help your heart bloom.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia’s heart skips, warmth rushing to her cheeks." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“O-Of course!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Of course I’ll come again… but are you sure that’s okay?“" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s alright”  
	“If you don’t mind me asking, what’s your name?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“If you don’t mind me asking, what’s your name?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Salvia. Nice to meet you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Mine is Camellia.“" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "..." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The evening passes quietly as they share gentle conversation and peaceful moments, until it’s time for Salvia to head home, and for Camellia to close the café." 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
]

var scene_day_2 = [
	{ "type": "SAY", "character": " ", 
	"text": "The sun rise. Inside Salvia’s room" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“A promise is a promise.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll go there after work.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia is such a nice person… I want to see her again.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Much nicer than what I have at my workplace.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“People there don’t really talk to me…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Maybe it’s because I’m too shy to say anything.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wonder what Camellia’s doing—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What am I thinking?! Focus! It’s almost time for work.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let’s get ready and head out.”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia walks down the same path as yesterday. As promised, she’s going back to the café." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Finally… I can go home.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What an exhausting day.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(It’s cold today)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Oh right, it’s winter.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Christmas is coming soon. I wonder how I’ll spend it…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Not that it matters. I always spend Christmas alone.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wish I could spend time with someone…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wonder if Camellia’s—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“N-No way, there is no chance foe me, right?...”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let’s just go to the café. It’s getting colder.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll pay her back this time.”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "Inside the café, the door opens and the bell rings. A lively group of cat girls and bunny girls enter." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Welcome!”" 
	},
	{ "type": "SAY", "character": "Girl A", 
	"text": "“Yoo-hoo! Miss Pink and Bun—same as usual, please!”" 
	},
	{ "type": "SAY", "character": "Girl B", 
	"text": "“I’ll have milk tea, please.”" 
	},
	{ "type": "SAY", "character": "Camellia ", 
	"text": " “Why, of course.”" 
	},
	{ "type": "SAY", "character": "Girl C", 
	"text": "”…U-uh”" 
	},
	{ "type": "SAY", "character": "Girl A", 
	"text": "“Come on, you can do it. Sorry—she’s new and a bit shy. Could you do your usual deduction thing again? Like before?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It's nothing special.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Now then.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Come here, Bun.”" 
	},
	#-------------------mini game
	{ "type": "SAY", "character": "Girl C", 
	"text": "“…I-it’s good!”" 
	},
	{ "type": "SAY", "character": "Girl A", 
	"text": "“Haha! See? Didn’t I tell you this place is great?”" 
	},
	{ "type": "SAY", "character": "Girl B", 
	"text": "“Thank you, Miss Pink and Bun.”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "The door opens again. The bell rings softly as Salvia steps inside." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“H-Hello, I’ve come again.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Welcome back. It’s lovely to see you again, Salvia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What can I get for you today?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Well, I’m just thinking of meeting you—I MEAN, a cup like yesterday, please!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(She seems to be in a better mood than yesterday.)" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camillia smiles softly and begins preparing the drink." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You seem brighter today.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“E-Eh?” (blush) “oh! You mean my mood, right!? haha…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“It’s better now. Thanks to you—and what you said yesterday.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I was only doing my job. I’m glad I could help, even a little.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Then please, let me thank you properly. May I tip you? Or is there anything I can help with?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": " “Hehe, what a cutie, if you want to make up to me so bad, then just pay what you owe”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Well, of course! I’d even pay extra!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Oh my… I couldn’t accept that—unless you’re asking for an extra~ special~ service.” " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "(She gently tucks a stray lock of hair behind her ear, her gaze lingering playfully on Salvia.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I-I—“" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia's bright red" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hehe, just kidding. But really, I can’t take the generosity like that, and it seems neither do you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hmm, so how about you help me out with some stuff in the back instead?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Is it really alright? I would hate to be a bother in there”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“No worry, I work alone in this café you see.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Any help is greatly appreciated.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": " “Of course, there’ll will be a reward for you”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Wink" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Y-Yes Ma-am”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They spend the night together, sharing quiet moments and gentle conversation." 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you, Salvia. You were a great help.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ve wanted to tidy up the back for a while now, but I’ve been too busy.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Would you like a drink before heading home?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Panting" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“H-How can you not be tired after all that cleaning and serving customers?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hehe, you get used to it. These are just my daily tasks.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Daily?!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll get you some water first.”" 
	},
	{ "type": "SAY", "character": "", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Now that we’re done, I suppose we’re even.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Though… I can’t help but feel like I should repay you again, hehe~”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“T-That’s really not necessary…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Otherwise we’ll end up stuck in an infinite loop of gratitude.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But… I wouldn’t mind helping again. It was actually fun.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll gladly accept—as long as you don’t overwork yourself.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’m fine with it. There’s not much waiting for me at home right now…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Is that so? Then I’ll make you work for me more.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Wink" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Haha, I’m joking.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Say, Salvia—if you don’t mind, may I give you my number?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“If you ever need anything, just call me.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Y-Your number? Yeah… I’d like that.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "It closing time, and Salvia heads home" 
	},
	
	{ "type": "SAY", "character": "", 
	"text": "Salvia stares at the number, a faint spark lighting her eyes." 
	},
	{ "type": "SAY", "character": "", 
	"text": "A small, excited squeal escapes as she buries her face into the pillow, smiling uncontrollably." 
	},
	{ "type": "SAY", "character": "", 
	"text": "Knowing this was the number of her first—and only—friend, someone she finally met in her early adulthood." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
]
var scene_time_skip_1 = [
	{ "type": "SAY", "character": " ", 
	"text": "As the days of the week slipped by, Salvia continued returning to the café whenever she had the chance, simply to spend time with Camellia." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They shared stories with each other—secrets they had spoken to anyone else." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They shared drinks and food, often staying longer than either of them intended." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They enjoyed each other’s company in a way that felt easy, natural, and unforced." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "No matter how exhausted Salvia was, she never turned down the chance to see Camellia." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As for Camellia, Salvia slowly began to grow on her." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "What had started as a kind and memorable customer soon became a close friend—perhaps something more than that." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Whatever the feeling truly was, Camellia knew one thing for certain" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "She was glad Salvia kept coming back to the café." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_3"},

]
var scene_day_3 = [
	{ "type": "SAY", "character": " ", 
	"text": " After work, Salvia walks to the café, trying to relax—but she looks more exhausted than usual." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": ":“What’s wrong, Salvia? You look more exhausted than usual lately.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Are you feeling alright?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Huh? Oh—sorry for making you worry.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’m fine… I think.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“How can that be fine? You look like you haven’t slept in ages.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“It’s just work… it’s been piling up on me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Is it normal for you to work that much?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“...No”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Let me guess—you were pushed into taking on your coworkers’ workload again?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“H-How did you know?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“From what I’ve learned about you these past days… you seem like the type who finds it hard to say ‘no’.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“...That’s true”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I don’t want to disappoint them. I feel like I have to say yes to whatever they ask.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“That’s just… how I live.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Do you actually want to do the work?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“No.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Do they ever thank you?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“...”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Listen, Salvia. It’s good to help people—but you have to realize what you’re doing to yourself.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You need to say ‘no’ more often.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“...I don't know”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What if they hate me for it?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You helped me before. I wouldn’t mind at all if you said ‘no’ to me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“In fact… looking at you now, I’d be relieved if you said ‘no’ more often.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I could never bring myself to hate you for that.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You really think so?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But… that might just be you.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I can’t talk to them the way I talk to you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Does it really matter if you keep doing their work while ignoring your own needs and happiness?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Maybe…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You have to be strong for yourself.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“If they’re truly good people, they’ll understand that you need help too.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“And if they don’t—if they only use you—then what’s stopping you from walking away?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I… I hope you’re right.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll try saying ‘no’ more… and asking for help when I need it.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll pray for your future well-being.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Do you ever have problems like this?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Oh, all the time. I just try to handle them more maturely.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You know… you’re very inspirational.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I want to help you with your problems too.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hehe, what a darling you are~”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“But I don’t want to bother you with my story.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I can handle my own.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m fine…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I wanted to say something, but I couldn’t)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why did she look so down? I don’t want to push if it hurts her this much.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Now then, would you like a drink and some snacks?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’d love that”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Thank you Camellia”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They spend the evening together, sharing troubles and offering advice, until it’s time for Salvia to head home and for Camellia to close the café." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Tomorrow… let’s both do our best.)" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_4"},
]
var scene_day_4 = [
	{ "type": "SAY", "character": " ", 
	"text": "After work" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“Hey, Salvia—want to join us for dinner?”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“My treat. Sorry for all the trouble we put you through before.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Huh? It’s okay… I didn’t really mind the workload.”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“Liar. I could tell how exhausted you were back then.”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“You really needed to speak up about how you were feeling.”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“Guess today… you finally did.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“S-Sorry…”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“Why are you apologizing?”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“The ones who kept pushing their work onto you should be the ones saying sorry—me included.”" 
	},
	{ "type": "SAY", "character": "Co-worker", 
	"text": "“So… I’m sorry, Salvia. I didn’t realize how much pressure you were carrying.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I-I…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Thank you… for saying all that to me, Mint.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I really needed to hear it.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Now come on—let’s eat. I’m not taking ‘no’ for an answer.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As Mint pulls her along, Salvia’s lips curve into a faint smile." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "For the first time in a long while, she feels seen—and respected." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_time_skip_2"},
]
var scene_time_skip_2 = [
	{ "type": "SAY", "character": " ", 
	"text": "As the days passed, Salvia began spending more time with her coworkers, slowly getting to know everyone in the office and growing especially close to Mint." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "What she once thought would be another day of endless work gradually became something she looked forward to each morning." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her work life grew less stressful, and before she noticed, she was genuinely enjoying it." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Even so, during those busy weeks, her thoughts often drifted back to the pink light that had guided her." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Between laughter with her coworkers and settling into a new routine, she hadn’t found the time to return." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Still, she quietly looked forward to the day they would meet again." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Elsewhere, Camellia continued her days at the café, working diligently without missing a beat." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "When Salvia stopped visiting, Camellia couldn’t help but wonder what had happened. " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "For a brief moment, she set aside her own worries and silently wished for Salvia’s well-being." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_5"},
]
var scene_day_5 = [
	{ "type": "SAY", "character": " ", 
	"text": "Inside the café. As the door opens and the bell rings, customers begin to trickle in." 
	},
	#----------after cafe minigame
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you for ordering. Here you go.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What a day…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her gaze drifts to a debt warning notice." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(It still wouldn’t be enough…)" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The door opens again. The bell rings softly as Salvia steps inside." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“H-Hello, Camellia… I’ve come again.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia! It’s been a while!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m so glad to see you again.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“How have you been?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Hehe, I’ve been well—fantastic, even! And it’s all thanks to you!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Wha—?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Well, first… I want to give you something.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "Salvia presents a bunny-shaped keychain." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I see you working with your bunny all the time, so I thought of you when I saw this.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Oh, thank you! You really didn’t have.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Look, Bun—it looks just like you! When did you become official merchandise? Haha.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia struggles to hold back an awkward smile." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Pfft—haha! Alright then, I’ll let your generosity slide just this once.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Please—would you like a drink, Salvia? It’s on the house.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“W-Well… there’s no point saying no to you, so yes, please.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia smiles softly as she prepares the drink." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“So… what’s been brightening you up so much?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Did something happen this past week?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I was worried my advice might’ve led you astray…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Eh? No! Your advice helped me a lot.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I tried what you said, and since then, so many things have changed.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“My coworkers are kinder, customers aren’t rude, and even my boss told me ‘good job’.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m really glad to hear that.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“And on top of all that… I got to see you again.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Aww, Salvia. I’m just a normal café owner—you don’t need to put me on a pedestal.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I kept trying to find time to visit you this past week, but work kept getting in the way.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wanted to thank you—from the bottom of my heart.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Ever since I met you, my life has gotten so much better.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Oh my… I don’t know what to say.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m just glad I could help.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You’re the first person who’s ever helped me this much.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You changed me.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I want to help you too—however I can.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I want to know you better, Camellia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(Wow, she’s so direct… it almost sounds like a confession.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I-I really don’t know what to say…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You think too highly of me. I don’t deserve that…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What do you mean? Of course you do. No one deserves it more than you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“P-Please… you’re exaggerating.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Let’s not rush ahead of ourselves.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”I’m glad that you have experienced what you deserve.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’d want nothing more than to see you smile.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I couldn’t have done it without you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hehe… look how adorable you are now.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“This calls for a celebration!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Wait here a moment—I’ll go prepare something special. I’ll even make a cake for you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“On the house, of course.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“N-No! I couldn’t possibly accept that!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“At least let me help you.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "..." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Once again, Salvia helps Camellia out, and they spend the evening together." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I should get going now.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll see you again, Camellia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Bye-bye, and thank you again, Salvia”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“A better life, huh…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia clenches her fist" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I wish… I could do that too.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_6"},
]
var scene_day_6 = [
	#---------after office minigame
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia walks down the same path as yesterday. She’s heading back to the café." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Today was great too… people are finally recognizing me.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Everything’s gotten better ever since I met Camellia.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I can’t wait to tell her about it—maybe I’ll even buy her a present this time.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But… what does she like?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…I don’t really know anything about her yet.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“She’s still almost a stranger to me, when it comes to relationships.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	
	{
		"type": "CHOICES", "options": {
			"I want to know her better": [
						
						],
			"I want to see her more": [
						
						],
			"I want… her…": [
						
						],
		}
	},
	
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Snap out of it" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Calm down, me. Don’t get any weird ideas.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I just appreciate what she did for me—that’s all.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“That… and her pretty face, her gentle voice—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Snap out of it" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“L-Let’s just go to the café.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why does my chest feel like this when I think about her?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Is this what people call ‘love’…?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“No way—that can’t be right. Haha…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“We’re both…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I should calm myself down for now.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Do I like her?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "SAY", "character": " ", 
	"text": "Inside the café, the door opens and the bell rings as customers come and go." 
	},
	#-----------after cafe minigame
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you, please come again!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her eyes fall on a rent notice." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“How can it be this much…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I didn’t plan for this…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What am I supposed to do…?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What a mess…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Useless…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“-Camellia? Camellia”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Hello?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Are you alright?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Snap" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Oh!”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia quickly hides the paper." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia! W-When did you get here?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Um, I just got here.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Never mind that, is everything ok?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You seem off.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I-It’s nothing! Really—please don’t worry.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Are you sure?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Y-Yes I’m sure!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s just been a busy day, that’s all…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“...”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“If you say so.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But if you need help with anything then please call me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Y-Yes, of course!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(I can’t tell anyone about this…)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(I can’t make her worry about my problems.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(She’ll think I’m a burden.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(This is my problem.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(I have to handle it on my own.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(If I can’t… then I really am useless.)" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“S-So… what would you like to drink today?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I can even make some cake for you.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“If that’s the case, then I’d like—”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia and Camellia spend the evening together as usual." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Yet, an unsettling feeling lingers—one Salvia can’t quite shake off." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Still, she chooses to ignore it, trusting that Camellia can handle things on her own." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Was that a mistake?" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_7"},
]
var scene_day_7 = [
	#--------after office minigame
	{ "type": "SAY", "character": "Mint", 
	"text": "“So, Salvia, who’s the lucky someone you’ve been dating, hmm?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“W-What!? Why would you say that!? I’m not dating anyone!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Come on, don’t lie to me.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“You’ve been smiling to yourself, spacing out, even giggling sometimes.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Totally not your usual self.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“You look like someone who just got proposed to.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“H-Haha! No way! No way!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“T-That would never happen!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I mean—I did meet someone, and they helped me and—and—”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“What are you, some kind of high school girl who just got her first love letter?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Ough…”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Introduce them to me sometime!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“I’d love to meet the person who makes you this happy.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“S-Shut up! I’m leaving!”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia walks down the same familiar path. She’s heading back to the café." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Can’t believe she teased me like that!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll get you back for that!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“‘My lucky person’ huh…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Come to think of it… who am I to Camellia?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“And who is she to me?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“We were strangers not that long ago…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“So why do I want to see her every single day?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Mint’s voice echoes in her head: “What are you, some kind of high school girl that just got her first love letter?”)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“W-Whatever! Get out of my head!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let’s just go to the café already.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "Standing in front of the familiar café, Salvia freezes." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "A small sign hangs on the door: “CLOSED”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…Huh?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Seems like she’s closed today…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wonder what happened…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ve heard shop owners can close whenever they feel like it”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But not Camellia of all people…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ve had an odd feeling ever since yesterday.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I hope everything’s okay.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll text her—just to be sure.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia pulls out her phone and starts typing." 
	},
	
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Hi! I’m at the café, but it looks like you’re closed today.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I just wanted to check up on you.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Is everything alright?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "…A moment passes. Then her phone vibrates." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”Hello, Salvia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”Everything is fine! Thank you for checking up on me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I wanted to open today, but I had some business to take care of.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“That’s all.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Ok, I’ll come back tomorrow then.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“See you then.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "readed message" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Guess I’ll just go home for today…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_8"},
]
var scene_day_8 = [
	#----------after office minigame
	{ "type": "SAY", "character": "Mint", 
	"text": "“Your boyfriend bothering you or something?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": " “It’s a girl, actually” " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The words slip out before she realizes" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Whoa. Didn’t expect you to be that bold.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“You said that without thinking, didn’t you?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“But wow, so it's like that huh.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": " “H-huh? Y-You didn’t hear that!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Hehe, right.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Still, if someone’s bothering you this much, maybe you should talk to them about it.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Just kidding, just kidding.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Oh, right—Christmas is coming up soon. Want to spend it with me?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“It could be a date—just you and me~” " 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“No, thanks.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Haha, rejected instantly!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Well, time to head home.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Good luck with your girlfriend, girlfriend. “" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“See you tomorrow.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…See you.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia walks down the familiar path once more." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I really hope she’s open today…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“She’s been acting strange lately.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Not that I know her well enough to say that…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Still, I hope everything’s okay on her side.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Christmas, huh…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wonder who she’ll spend it with.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“If only that could be with me—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“W-What am I saying!? That’s impossible. Haha…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Maybe… I really do like her after all.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But I don’t want to ruin what we have.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What should I do…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Sigh" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "Standing in front of the café once again, Salvia stops short." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The familiar sign hangs on the door." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "“CLOSED”" 
	},
	
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…She’s closed again.”Salvia" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“And she didn’t message me at all today…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wonder what she’s doing right now.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Guess I’ll head home again.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Hm?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What’s this?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She notices a piece of paper stuck under the door." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She pulls it out and reads." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“A bill…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why is it so high…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Did someone drop this? Why would it be here?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Unless…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia… is this what you’ve been worried about?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why didn’t you say anything…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But… what can I even do to help?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Calm down, I don’t even know if this is really her problem.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll try asking her about it when we meet again.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I hope you’re doing okay, Camellia.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let’s go home for now.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_9"},
]
var scene_day_9 = [
	{ "type": "SAY", "character": " ", 
	"text": "Inside the café." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Only a few more days…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You’ve been a good place…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I really thought I could handle everything on my own…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“There’s still some time before I leave and return home.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Let try our best until then.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The door opens, the bell rings. Customers begin to appear." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Ah—welcome.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What can I get for you today?”" 
	},
	#------------------after cafe minigame
	{ "type": "SAY", "character": "Camellia", 
	"text": "" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you for ordering. Here you go.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Sigh" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Why does today feel so exhausting…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I don’t even have the strength to clean anymore.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“No matter how hard I try…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s never enough.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I just want to be alone right now.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Maybe I should close early today…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	
	#------------
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia walks down the familiar path once again." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I really hope she’s open today…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As the sky begins to drizzle, Salvia approaches the café." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She stops." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia is standing in front of the door, the “Closed” sign hanging quietly behind her." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia stares at the door, her posture still—heavy with sorrow." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia…?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia steps closer." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia, are you—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Gasps" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Tears stream down Camellia’s face, partially hidden beneath her hair." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia clenches her fists and rushes forward." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She reaches out, grasping Camellia’s hand." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”O-Oh!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”Salvia!?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”What are you doing here—?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She hurriedly wipes her face, flustered" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia, I… I…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia suddenly pulls Camellia into a tight embrace." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”—!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Please… please…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“D-Don’t cry anymore”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”Salvia… are you crying for me?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia holds her tighter, tears spilling freely." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Whatever you’re going through… please let me help you.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I don’t want you to leave anymore.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I don’t want you to cry alone.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I want to see you smile…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia let out a small, shaky giggle" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "”I-I don’t understand…” " 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Why would you do all this for me?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I don’t deserve any of it—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You’re wrong!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You’re the most wonderful person I’ve ever met.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You’ve given me nothing but warmth.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“So don’t you dare say that about yourself.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia tightens her embrace, holding back her sobs." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "There were so many things she wanted to say—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "But her heart was too full, her voice lost to tears." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…You really are kind, Salvia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia slowly returns the hug." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They stand together in silence as soft rain falls around them." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Listen, Salvia…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m going to close the café and move away at the end of this month.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll be taking a train… somewhere far away.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I can’t keep this place running on my own anymore.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“So… it’s better if you forget about me.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“No—how could I!?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“There has to be another way!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It was bound to happen eventually.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I knew this day would come.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“That’s just how things are.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Then why are you sad?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“If you expected this…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " Camellia let out a soft giggle" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Yes, you’re right.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I wonder that myself.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Maybe I’m just… lost right now.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…Cold”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Hm?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You told me before—that you feel lost when you’re alone and cold.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Did I now?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Christmas”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Christmas…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Christmas is coming soon, there’s a festival…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia, would you like to spend it with me?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I want to show you warmth!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“My warmth…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia eyes widening, then softening into a smile" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“W-Well, how can I possibly say no to that now? So unfair…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "Then...”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s a date.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia smiles, genuine and bright." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia smiles back." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Look at the time, we should really be heading home.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Want me to walk you?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“No—no, it's fine, I can walk by myself.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You should head home, too. I don’t want you catching a cold in this rain.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll be going now, see you tomorrow” " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia turns and walks away." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As Camellia walks through the rain, she blushes softly—" 
	},
	{ "type": "SAY", "character": "", 
	"text": "A small, quiet giggle escaping her lips." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": " “See you then…”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_time_skip_3"},
]
var scene_time_skip_3 = [
	{ "type": "SAY", "character": " ", 
	"text": "Day by day, as Christmas draws ever closer, they both work tirelessly, preparing for the coming holiday." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia looks forward to spending it with someone she cares deeply for—though the reality is far different from what she once imagined." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "This is a day she cannot afford to make a mistake on." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "As for Camellia, she remains uncertain about the path she now stands on." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Yet she cannot deny Salvia’s sincerity, and that alone makes her anticipate their next meeting…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "All the while knowing it may be the very last time they see each other." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_10"},
]
var scene_day_10 = [
	{ "type": "SAY", "character": " ", 
	"text": " Salvia leaves work early today to prepare. When she asks her coworkers for help, she’s met with cheerful smiles and warm encouragement—something that still feels unreal to her." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The night of the Christmas festival." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Good evening, Salvia.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia approaches, wrapped in a soft pink coat. Salvia, in blue, turns to face her." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "*Gulp" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“G-Good evening, Camellia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Shall we get going?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Yes.”" 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "Time drifts by as they wander through town together—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Sharing warm food, playing games, laughing freely." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Letting the noise, the lights, and the cold fade into the background." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "For a while, the world feels small… and kind." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I wanted to show her warmth… and I think I did.)" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia turns toward Salvia, smiling softly." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you, Salvia. Tonight has been… wonderful.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I wish this could last forever…)" 
	},
	
	
	{ "type": "SAY", "character": " ", 
	"text": "As the festival winds down, people slowly head home." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The night air is cool, the sky faintly glowing with the last traces of color." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia and Salvia walk side by side, their footsteps quiet against the street." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you for today, Salvia.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It was really fun.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“It’s been so long since I went to a festival with someone.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "”Is that so?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Then… I’d love to go out with you more.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia’s heart skipped" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "(Did she really say that—so earnestly?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I wouldn’t mind doing this again next year. With you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Y-Yes… I’d like that too. It was really fun.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Then Camellia… can we stay in contact when you’re away?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I still want to talk with you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Of course we can—”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her words trail off. Camellia lowers her gaze." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia, as much as I’d like to stay with you, I don’t think it’s a good idea.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll be moving far, far away soon.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“And I don’t plan on coming back.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“So… I think it’s best if you forget about me.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia abruptly pins Camellia to a wall, her hand firm beside Camellia’s shoulder." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“After all we've been through…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Don’t ever say that again, Camellia.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“It’s my choice to want to stay in touch with you.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“If you can’t come to me—then I’ll come to you.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia freezes, face burning red, unable to meet Salvia’s eyes." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia slowly leans closer, their faces inches apart—close enough to feel each other’s breath." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Suddenly, Salvia realizes what she’s doing. Her eyes widened. She quickly pulls back, flustered and panicked." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I-I’m so sorry about that!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“A-Are you hurt?! I didn’t mean to scare you!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…W-Water…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Water? I’ll get you some water.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "They sit together quietly afterward." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The tension slowly melts into something softer—gentler." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "A shared silence. A quiet understanding." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Soon after, they part ways." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’m leaving next week. By train.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll come see you off.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“You’re so kind, Salvia…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Would you like a drink in the café tomorrow?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll make one for you, just like the usual days.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’d love to.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I will make it extra special for you…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“...”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Well then… good night, Salvia.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "That day never came to be." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_11"},
]
var scene_day_11 = [
	{ "type": "SAY", "character": " ", 
	"text": "After work, Salvia rushes toward the café." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "When she arrives, the familiar sign greets her." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "CLOSED" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Maybe she’s just late…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let me try calling her.”" 
	},
	{ "type": "SAY", "character": "", 
	"text": "…’The number you are calling doesn’t exist’" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…What?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“That’s… strange.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Let me try texting her… account doesn’t exist?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "”No—no, she deleted her account!?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“W-why would she do that?!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Didn’t she say we’d keep in contact?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why? Why?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why? Why? Why?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Why…?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her questions echo, unanswered." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_time_skip_4"},
]
var scene_time_skip_4 = [
	{ "type": "SAY", "character": " ", 
	"text": "Days pass without a single word from Camellia." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "With each passing day, Salvia’s worry only deepens." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She can’t stop thinking about her—about what she could possibly do to change this." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Yet no answer comes to mind." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She feels completely helpless." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "The day Camellia will be truly gone draws ever closer." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "What should she do?" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "ROUTE", "data": "scene_day_12"},
]
var scene_day_12 = [
	{ "type": "SAY", "character": " ", 
	"text": "After what happened, Salvia can’t shake the confusion—or the ache in her chest." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Restless. Upset. Lost." 
	},
	#-----after office minigame
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why would she cut me off like that?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(How could she?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Salvia! Calm down—you’re throwing paper balls at me!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Hmph!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Hey, seriously girl! At this rate, we’ll both get fired!”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“What’s going on with you?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Tell me what happened.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…If someone you cared about suddenly cut ties with you, how would you feel?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Hm…?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Well, I’d be pretty mad.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“But it depends.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Context?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Did they leave me because they’re a jerk and got bored?”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Or did they leave me because they thought it was for the greater good?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“…”" 
	},
	
	#----------Could be a choice here
	
	{ "type": "SAY", "character": "Mint", 
	"text": "“I’d still be pretty mad either way.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“But sometimes… you don’t get closure unless you chase it.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "”...”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Maybe I readed too much romance fiction after all…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Oh no…)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I have to go meet Camellia…)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I must!)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Mint… can you cover for me? Please. I’ll repay you.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Sure—but where are you going?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Please… I need to go after her. Before it’s too late.”" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "*Sighs" 
	},
	{ "type": "SAY", "character": "Mint", 
	"text": "“Go get them, girl.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Thank you!”" 
	},
	
	
	
	{ "type": "SAY", "character": " ", 
	"text": "Racing toward the train station." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia’s feet pound against the pavement, her heart racing faster than her breath." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Is it really okay for us to end like this…?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Should I just move on?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Should I forget her…?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(No—I don’t want to.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(She was my warmth.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Her train is leaving soon.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(And if I miss this… I might never see her again.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Is this what she wanted…?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Is this what I really want?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(…Who am I kidding.)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(I have to see her.)" 
	},
	
	
	
	
	{ "type": "SAY", "character": " ", 
	"text": "Camellia stands among the departing passengers, suitcase by her side." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Her gaze is distant." 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Wait—!“" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia’s panting, catching her breath" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia…?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Salvia, how did you know I was here?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I asked around town.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Turns out, everyone knows the fluffy pink-haired café owner.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“There was even a group of bunny girls and cat girls who helped me find ‘Miss Pink’“" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“They said it’d be a shame if you left without a proper goodbye.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…They did all that…?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“A-And you…?”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia still trying to catch her breath" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But that doesn’t matter right now…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Inhales, exhales" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Camellia…“" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I love you!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Eek—!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I won’t let you carry everything alone anymore!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I'll be there whenever you feel down!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I promise I won’t let you go.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I’ll keep you warm—always.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“So please—will you stay with me?”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I-I don’t know what to say…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“...”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia eyes tremble. Guilt and longing press heavily against her chest." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I… I was so afraid.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Hic" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Afraid I’d hold you back…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "*Hic" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Afraid I wasn’t enough…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I can’t go back after what I did—”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“I know.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“You did it because you cared.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“And now I know how important you are to me.”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“So please, Camellia…”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“Stay with me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia nods—slowly at first, then with certainty." 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Yes…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Yes… I want to stay”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I want to be with you!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I love you!”" 
	},
	{ "type": "SAY", "character": "", 
	"text": "" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Camellia rushes forward." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "—" 
	},
	#------cg here
	{ "type": "SAY", "character": " ", 
	"text": "They embrace—then kiss—as the train departs behind them." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	{ "type": "SAY", "character": " ", 
	"text": "As they hold each other close, leaving behind their old lives." 
	},
	{ "type": "SAY", "character": "", 
	"text": "They open a new café together—" 
	},
	{ "type": "SAY", "character": "", 
	"text": "Filled with shared hobbies, cozy memories, warm drinks…" 
	},
	{ "type": "SAY", "character": "", 
	"text": "and above all—" 
	},
	{ "type": "SAY", "character": "", 
	"text": "Blooming their hearts with love." 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "SAY", "character": " ", 
	"text": "GOOD ENDING" 
	},
	#{ "type": "ROUTE", "data": "scene_day_4"},
]


#---------ENDING
var scene_salvia_bad_ending = [
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“What do you mean… I got fired?!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“But I tried so hard—!”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "“And it still wasn’t enough…?”" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "…" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	#new scene appear here
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why… why… why…)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why am I so useless?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why couldn’t I have been better?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why did all my effort amount to nothing?)" 
	},
	{ "type": "SAY", "character": "Salvia", 
	"text": "(Why… why… why…)" 
	},
	
	
	
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Salvia curled up in the darkness of her room, sobbing quietly." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She refused to open the door—refused to face the world ever again." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Yet deep down, an ache lingered in her chest." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "A quiet, unbearable feeling that she had lost something or someone important." 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "SAY", "character": " ", 
	"text": "BAD ENDING"
	},
]

var scene_camellia_bad_ending = [
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“What do you mean the rent was raised?!”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I can’t afford this…”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“How am I supposed to—”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“...”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“Thank you for informing me.”" 
	},
	{ "type": "SAY", "character": "Camellia", 
	"text": "“I’ll vacate the shop by tomorrow.”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
		#new scene appear here
		
	{ "type": "SAY", "character": "", 
	"text": "(So this is it…)" 
	},
	{ "type": "SAY", "character": "", 
	"text": "(It came sooner than I expected.)" 
	},
	{ "type": "SAY", "character": "", 
	"text": "(If I had tried harder… would anything have changed?)" 
	},
	{ "type": "SAY", "character": "", 
	"text": "(No… it’s already too late.)" 
	},
	{ "type": "SAY", "character": "", 
	"text": "..." 
	},
	{ "type": "SAY", "character": "", 
	"text": "“Goodbye”" 
	},
	{ "type": "SAY", "character": "", 
	"text": "“And sorry…”" 
	},
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": "Camellia leaves the café quietly, her steps heavy with regret." 
	},
	{ "type": "SAY", "character": " ", 
	"text": "Even as she walks away, a single thought lingers in her heart—" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "What if there was something she could have done differently?" 
	},
	{ "type": "SAY", "character": " ", 
	"text": "nd no matter how hard she tries to ignore it," 
	},
	{ "type": "SAY", "character": " ", 
	"text": "She can’t shake the feeling that she’s leaving someone behind." 
	},
	
	{ "type": "SAY", "character": " ", 
	"text": " " 
	},
	
	{ "type": "UI_HIDE"},
	{ "type": "UI_SHOW"},
	{ "type": "SAY", "character": " ", 
	"text": "BAD ENDING"
	},
]
