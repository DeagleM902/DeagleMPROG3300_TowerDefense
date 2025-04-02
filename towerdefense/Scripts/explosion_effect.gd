extends Area2D

func explode(source, explosion_damage):
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	var enemies = get_overlapping_bodies()
	print_debug(enemies)
	for enemy in enemies:
		if enemy.has_method("take_damage"):
			enemy.take_damage(explosion_damage)
			
	$AnimationPlayer.play("explode")
	await $AnimationPlayer.animation_finished
	queue_free()
