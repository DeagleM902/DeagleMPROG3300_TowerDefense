extends Weapon
class_name FireballWeapon

func shoot(source, target, scene_tree):
	if target == null:
		return
	
	var projectile = projectile_node.instantiate()
	
	projectile.position = source.global_position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = (target.global_position - projectile.position).normalized()
	projectile.rotation = projectile.direction.angle()
	
	scene_tree.current_scene.add_child(projectile)
	
func activate(source, target, scene_tree):
	if scene_tree.paused:
		return
	shoot(source, target, scene_tree)
