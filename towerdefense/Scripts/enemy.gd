extends CharacterBody2D

@export var player_reference : CharacterBody2D
var direction : Vector2
@export var speed : float = 75
var damage : float
var knockback : Vector2
var separation : float


var health : float:
	set(value):
		health = value
		if health <= 0:
			queue_free()

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
		damage = value.damage
		health = value.health

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false

func take_damage(amount):
	health -= amount
