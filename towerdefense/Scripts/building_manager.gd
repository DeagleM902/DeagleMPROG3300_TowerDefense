extends Node
class_name BuildingManager

const IS_BUILDABLE : String = "buildable"
const TOWER_GROUP : String = "TOWER_GROUP"

@export var level : TileMapLayer = null
var used_tiles : Array[Vector2i] = []

#Trying tower types
const archer_tower = preload("res://Resources/Towers/ArcherTower.tres")
const fire_tower = preload("res://Resources/Towers/FireballTower.tres")
const lightning_tower = preload("res://Resources/Towers/LightningTower.tres")
var tower_selection = [archer_tower, fire_tower, lightning_tower]
var current_tower = tower_selection[0]

func set_tower_selection (index : int):
	current_tower = tower_selection[index]

#Tower Creation

#Tower Placement
#Places the tower on grid, adds to tree
func place_tower(cell_position : Vector2i, tower_packed_scene : PackedScene) -> void:
	if check_valid_tower_placement(cell_position) == false || !GameManager.spend_coins(current_tower.cost):
		return
	
	var new_tower : CharacterBody2D = tower_packed_scene.instantiate()
	
	new_tower.tower_type = current_tower
	
	add_child(new_tower)
	
	new_tower.position = cell_position * 16 
	new_tower.add_to_group(TOWER_GROUP)
	used_tiles.append(cell_position)

#Tower Grouping

#Used Tile Tracking
#If tower already placed here, do nothing.
func check_valid_tower_placement(cell_position : Vector2i) -> bool:
		if used_tiles.has(cell_position):
			return false
		var cell_data = level.get_cell_tile_data(cell_position).get_custom_data(IS_BUILDABLE)
		return cell_data
