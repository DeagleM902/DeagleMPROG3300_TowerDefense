extends Node2D
class_name TestLevel

@export var tower_packed_scene : PackedScene = null
@export var building_manager : BuildingManager = null
@onready var level: TileMapLayer = $Map/Level

func _ready():
	SoundManager.play_music(preload("res://Audio/Music/SynFantasy Vol3 Forest Tavern Intensity 2.wav"))

#Tower placement on grid with mouse click
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position : Vector2i = level.local_to_map(level.get_local_mouse_position())
		building_manager.place_tower(cell_position, tower_packed_scene)
