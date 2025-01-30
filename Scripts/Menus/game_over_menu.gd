class_name GameOverMenu
extends CanvasLayer


@onready var play_button: BaseUIButton = $Buttons/PlayButton
@onready var config_button: BaseUIButton = $Buttons/ConfigButton
@onready var return_button: BaseUIButton = $Buttons/ReturnButton
@onready var config_menu: ConfigMenu = $ConfigMenu


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	config_button.pressed.connect(_on_config_button_pressed)
	return_button.pressed.connect(_on_return_button_pressed)
	
	GameState.save_score()

func _on_play_button_pressed() -> void:
	PlayerVariables.reset()
	get_tree().change_scene_to_file("res://Scenes/level_01.tscn")
	
func _on_config_button_pressed() -> void:
	config_menu.show()

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
