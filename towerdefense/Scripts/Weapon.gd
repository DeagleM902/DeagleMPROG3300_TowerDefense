extends Resource
class_name Weapon

@export var damage : float
@export var cooldown : float
@export var speed : float

@export var texture : Texture2D

@export var projectile_node : PackedScene = preload("res://Scenes/projectile.tscn")

#abstract method, override
func activate(_source, _target, _scene_tree):
	pass
