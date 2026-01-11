extends Node2D
 
@onready var currentSong = $music_rock

var nocurrentsong = false
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_musicRESET()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not currentSong.is_playing() and nocurrentsong==false:
		currentSong.play()

func _musicRESET():
	nocurrentsong = true
	$music_tea.stop()
	$music_rock.stop()
	$music_gameover.stop()

func _music_gameOver():
	_musicRESET()
	$music_gameover.play()
	currentSong = $music_gameover
	nocurrentsong = false
	
func _music_rock():
	_musicRESET()
	$music_rock.play()
	currentSong = $music_rock
	nocurrentsong = false
	
func _music_teal():
	_musicRESET()
	$music_tea.play()
	currentSong = $music_tea
	nocurrentsong = false

#------------------------
func _efx_hit():
	$efx/hit.play()
func _efx_last_blow():
	$efx/lastBlow.play()
func _efx_hit_misso():
	$efx/hitMisso.play()
func _efx_block():
	$efx/block.play()
func _efx_jump():
	$efx/jump.play()
func _efx_select():
	$efx/select.play()
func _efx_pageFlip():
	$efx/pageFlip.play()
func _efx_crash():
	$efx/crashCat.play()
func _efx_parry():
	$efx/parry.play()
func _efx_bell_ding():
	$efx/bellDing.play()
func _efx_grapped():
	$efx/grapped.play()

#------------------------
func _voice_round_one():
	$voice/roundOne.play()
func _voice_round_two():
	$voice/roundTwo.play()
func _voice_round_three():
	$voice/roundThree.play()
func _voice_ready():
	$voice/ready.play()
func _voice_focus():
	$voice/focus.play()
func _voice_focusfocus():
	$voice/focusfocus.play()
func _voice_guard():
	$voice/guard.play()
func _voice_ohmygotto():
	$voice/ohmygotto.play()
