extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 175
var damage : float = 1
var source

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_screen_exited() -> void:
	queue_free()
