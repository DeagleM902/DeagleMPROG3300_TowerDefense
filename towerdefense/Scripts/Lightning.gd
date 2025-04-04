extends Weapon
class_name Lightning

var projectiles = []

func activate(source, _target, scene_tree):
	if scene_tree.paused == true:
		return
	shoot(source, scene_tree)

func shoot(source, scene_tree : SceneTree):
	var tower = source.get_parent()
	var enemies = tower.enemyArray
	if enemies.size() == 0:
		return
	
	for i in range(enemies.size()):
		var enemy = enemies[i]
		
		var projectile = projectile_node.instantiate()
		projectile.speed = 0
		projectile.damage = damage
		projectile.source = source
		projectile.position = enemy.position #Lightning will hit the enemy directly, no travel
		
		projectile.find_child("Sprite2D").texture = texture
		projectiles.append(projectile)
		scene_tree.current_scene.add_child(projectile)
	
	#Timer controls how long the effect is visible
	await scene_tree.create_timer(0.25).timeout
	for i in range(projectiles.size()):
		var temp = projectiles.pop_front()
		if is_instance_valid(temp):
			temp.queue_free()
