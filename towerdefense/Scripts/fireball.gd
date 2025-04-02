extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 175
var damage : float = 1
var source
@export var explosion_scene : PackedScene


func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		#body.take_damage(damage)
		
		var explosion = explosion_scene.instantiate()
		get_parent().add_child(explosion)
		explosion.global_position = global_position
		explosion.explode(source, damage)
		$Sprite2D.hide()
		
		queue_free()

func _on_screen_exited() -> void:
	queue_free()
