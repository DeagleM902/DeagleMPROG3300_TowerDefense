extends Area2D
@export var health : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%HealthLabel.text = "Health: " + str(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		GameManager.game_over()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		health -= body.damage
		%HealthLabel.text = "Health: " + str(health)
		body.queue_free()
