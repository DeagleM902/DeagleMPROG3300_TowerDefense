extends Node

@export var enemy_scene: PackedScene
@export var spawn_marker: Marker2D
@export var target_pos : Marker2D = null
@export var pathfinding_manager : PathfindingManager = null

# Array of wave data.
# "enemy": Enemy resource (defines stats, texture, etc.)
# "count": Number of enemies to spawn in this wave.
# "spawn_interval": Time (in seconds) between spawns.
@export var waves: Array[Dictionary] = [
	{"enemy": preload("res://Resources/Enemies/Goblin.tres"), "count": 5, "spawn_interval": 1.0},
	{"enemy": preload("res://Resources/Enemies/Bat.tres"), "count": 3, "spawn_interval": 2.0}
]
var current_wave: int = 0
var enemy_spawned_count: int = 0
var spawning_wave: bool = false

func _ready() -> void:
	# Optionally, delay the start of the first wave or let the GameManager trigger it.
	start_wave()

func start_wave() -> void:
	#Make sure all enemies are dead
	if current_wave >= waves.size():
		print("No more waves!")
		GameManager.win_game()

	enemy_spawned_count = 0
	spawning_wave = true
	spawn_next_enemy()

func spawn_next_enemy() -> void:
	if not spawning_wave:
		return
	
	if current_wave >= waves.size():
		return
	
	var wave_data = waves[current_wave]
	if enemy_spawned_count < wave_data["count"]:
		# Instance a new enemy.
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_marker.global_position
		enemy.target_pos = target_pos
		enemy.pathfinding_manager = pathfinding_manager
		
		# Set enemy type and properties from the wave data.
		enemy.type = wave_data["enemy"]
		enemy.speed = wave_data["enemy"].speed
		enemy.health = wave_data["enemy"].health
		enemy.damage = wave_data["enemy"].damage

		get_parent().add_child.call_deferred(enemy)
		
		enemy_spawned_count += 1
		
		# Schedule the next enemy spawn after the spawn interval.
		await get_tree().create_timer(wave_data["spawn_interval"]).timeout
		spawn_next_enemy()
	else:
		# Wave complete. GAME MANAGER END WAVE!!!
		spawning_wave = false
		
		await wait_until_enemies_defeated()
		print("Wave ", current_wave, " complete.")

		#Make sure all enemies are dead
		#Just start a new wave after 3s for now
		current_wave += 1
		await get_tree().create_timer(3.0).timeout
		start_wave()

func wait_until_enemies_defeated():
	while get_tree().get_nodes_in_group("Enemies").size() > 0:
		await get_tree().create_timer(0.5).timeout
