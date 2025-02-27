extends Node
class_name BuildingManager

const IS_BUILDABLE : String = "buildable"
const TOWER_GROUP : String = "TOWER_GROUP"

@export var level : TileMapLayer = null
var used_tiles : Array[Vector2i] = []

#Tower Creation

#Tower Placement
#Places the tower on grid, adds to tree
func place_tower(cell_position : Vector2i, tower_packed_scene : PackedScene) -> void:
	if check_valid_tower_placement(cell_position) == false:
		return
	
	var new_tower : CharacterBody2D = tower_packed_scene.instantiate()
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
