extends Node2D


@onready var musics = [
	$Musics/AudioStreamPlayer2D,
	$Musics/AudioStreamPlayer2D2,
	$Musics/AudioStreamPlayer2D3
]

@onready var EFXs = [
	$Efxs/AudioStreamPlayer2D,
	$Efxs/AudioStreamPlayer2D2,
	$Efxs/AudioStreamPlayer2D3
]

@onready var voices = [
	$Voices/AudioStreamPlayer2D
]

var currentSong: AudioStreamPlayer2D
var nocurrentsong = false

func _ready() -> void:
	_musicRESET()


#MUSIC------------------------
func _process(delta: float) -> void:
	if currentSong != null and not currentSong.is_playing() and nocurrentsong==false:
		currentSong.play()

func _musicRESET():
	nocurrentsong = true
	for i in musics:
		if i != null:
			i.stop()

func _musicPLAY(title: String):
	_musicRESET()
	for music in musics:
		if music != null and music.name == title:  
			music.play()
			currentSong = music
			nocurrentsong = false
			return  

#EFX------------------------
func _efxPLAY(title: String):
	for efx in EFXs:
		if efx != null and efx.name == title:
			efx.play()
			return  

#func _efx_hit():
	#$efx/hit.play()

	
#VOICE------------------------

func _voicePLAY(title: String):
	for voice in voices:
		if voice != null and voice.name == title:
			voice.play()
			return  
			
#func _voice_round_one():
	#$voice/roundOne.play()
