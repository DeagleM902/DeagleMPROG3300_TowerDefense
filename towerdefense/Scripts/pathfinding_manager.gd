extends Node
class_name PathfindingManager

@export var tile_map_grid : TileMapLayer = null

var astar_grid : AStarGrid2D = AStarGrid2D.new()
var path_array : Array[Vector2i] = []

func _ready() -> void:
	set_up_astar_grid()

func set_up_astar_grid() -> void:
	astar_grid.region = tile_map_grid.get_used_rect()
	astar_grid.cell_size = tile_map_grid.tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES #test other modes if desired
	astar_grid.update()
	
	update_terrain_movement_values()

func update_terrain_movement_values() -> void:
	for i in tile_map_grid.get_used_cells():
		if get_cell_movement_cost(i) <= 1:
			astar_grid.set_point_weight_scale(i, get_cell_movement_cost(i))
		else:
			astar_grid.set_point_solid(i, true)

func get_valid_path(start_position : Vector2i, end_position : Vector2i) -> Array[Vector2i]:
	path_array.clear()
	for point in astar_grid.get_point_path(start_position, end_position):
		var current_point : Vector2i = point
		current_point += astar_grid.cell_size / 2 as Vector2i
		
		path_array.append(current_point)
	return path_array

func get_cell_movement_cost(cell_position : Vector2i) -> int:
	return tile_map_grid.get_cell_tile_data(cell_position).get_custom_data_by_layer_id(0)
