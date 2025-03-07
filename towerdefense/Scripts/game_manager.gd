extends Node

var is_wave_complete : bool = true

func game_over():
	get_tree().reload_current_scene() #should display retry button, other effect
	#get_tree().paused = true
	#display retry button
	#retry button on_pressed(): GameManager.new_game()
	
func win_game():
	#Show congrats ui
	#Retry / next level / main menu button(s)
	print_debug("You Win!")
	await get_tree().create_timer(5.0).timeout
	print_debug("Restarting Game")
	new_game()
	return

func new_game():
	get_tree().reload_current_scene()
	get_tree().paused = false

func start_wave():
	is_wave_complete = false
	#Hide start wave button
	return
	
func end_wave():
	is_wave_complete = true
	#triggered when spawning is complete AND enemies are all dead/removed
	#Show start wave button
	return
