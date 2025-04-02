extends Control

func _ready() -> void:
	SoundManager.play_music(preload("res://Audio/Music/SynFantasy Vol3 Forest Tavern Intensity 1.wav"))


func _process(delta: float) -> void:
	pass
	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
