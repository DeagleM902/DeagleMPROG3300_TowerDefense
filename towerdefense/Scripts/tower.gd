extends CharacterBody2D
var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float
@onready var cooldown_timer: Timer = $Cooldown

var enemyArray : Array [CharacterBody2D] = []

@export var weapon: Weapon
		
func _ready() -> void:
	if weapon:
		cooldown_timer.wait_time = weapon.cooldown
		print_debug("Cooldown found")
		
func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance =  nearest_enemy.separation
	else:
		nearest_enemy = null
	
func _on_cooldown_timeout() -> void:
	var target = get_target()
	if target:
		weapon.activate(self, target, target.get_tree())
func get_target():
	if enemyArray.size() > 0:
		return enemyArray[0]
	else:
		return null

func _on_range_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("take_damage"):
		if (!enemyArray.has(body)):
			enemyArray.append(body)
		print(body)

func _on_range_body_exited(body: CharacterBody2D) -> void:
	if (enemyArray.has(body)):
		enemyArray.erase(body)
