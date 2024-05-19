extends AudioStreamPlayer2D

func _play_music(music: AudioStream = preload("res://assets/audio/music/2019-12-09_-_Retro_Forest_-_David_Fesliyan.mp3"), volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music()
