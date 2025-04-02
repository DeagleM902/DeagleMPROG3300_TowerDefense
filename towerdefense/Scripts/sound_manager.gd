extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func play_music(track : AudioStream, volume: float = -20.0):
	music_player.stream = track
	music_player.volume_db = volume
	music_player.play()
	
func stop_music():
	music_player.stop()
