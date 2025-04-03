extends Node

signal coins_updated(new_value : int)
signal end_game(won : bool)

var is_wave_complete : bool = true
var coins : int = 20:
	set(value):
		coins = value
		coins_updated.emit(value)

func game_over():
	end_game.emit(false)
	
func win_game():
	end_game.emit(true)

func new_game():
	get_tree().reload_current_scene()
	adjust_coins(20)
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

func adjust_coins(amount: int) -> void:
	coins = amount
		
func add_coins(value: int):
	coins += value

func remove_coins(value: int):
	coins -= value
	
func spend_coins(amount: int) -> bool:
	if coins >= amount:
		coins -= amount
		return true
	return false
