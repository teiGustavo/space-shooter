class_name BestScoreMenu
extends CanvasLayer


@onready var return_button: BaseUIButton = $Buttons/ReturnButton
@onready var score_value: Label = $Score/Value


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	score_value.text = str(GameState.best_score)
	
func _on_return_button_pressed() -> void:
	TransitionManager.fade_to_scene("res://Scenes/Menus/main_menu.tscn")
