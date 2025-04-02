extends CharacterBody2D

@export var speed : float = 50
var target_pos : Marker2D = null
var pathfinding_manager : PathfindingManager = null
@export var damage : float = 1
@export var coins : int = 1

@export var health : float = 3:
	set(value):
		health = value
		if health <= 0:
			GameManager.add_coins(coins)
			queue_free()

var path_array : Array[Vector2i] = []

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shaders/Rainbow.tres")
			scale = Vector2(1.5,1.5)

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		health = value.health

func _ready() -> void:
	add_to_group("Enemies")
	path_array = pathfinding_manager.get_valid_path(global_position / 16, target_pos.position / 16)
	
func _process(delta):	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
	
	get_path_to_position()
	move_and_slide()


func get_path_to_position() -> void:
	if len(path_array) > 0:
		var direction : Vector2 = global_position.direction_to(path_array[0])
		velocity = direction * speed
		
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0)
	else:
		velocity = Vector2.ZERO

func take_damage(amount):
	health -= amount
