extends Control

@onready var title_label: Label = $Panel/TitleLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameManager.end_game.connect(_on_end_game)

func _on_end_game(won: bool):
	title_label.text = "You Win!" if won else "You lose :("
	visible = true
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	GameManager.new_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
