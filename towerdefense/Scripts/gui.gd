extends Control
@export var building_manager : BuildingManager = null
@onready var coins_label : Label = $Label


func _ready() -> void:
	GameManager.coins_updated.connect(_on_coins_updated)
	coins_label.text = "Coins: " + str(GameManager.coins)

func _on_coins_updated(new_value: int):
	coins_label.text = "Coins: " + str(GameManager.coins)

func _process(delta):
	var towers = building_manager.tower_selection

	for i in range($HBoxContainer.get_child_count()):
		var button = $HBoxContainer.get_child(i)
		
		if not button is Button or i >= towers.size():
			continue
		var tower = towers[i]
		button.disabled = GameManager.coins < tower.cost

func _on_archer_button_pressed() -> void:
	building_manager.set_tower_selection(0)


func _on_fire_button_pressed() -> void:
	building_manager.set_tower_selection(1)


func _on_lightning_button_pressed() -> void:
	building_manager.set_tower_selection(2)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_tree().paused = true
	if !toggled_on:
		get_tree().paused = false
