class_name PauseMenu
extends BasePopupMenu


@onready var play_button: BaseUIButton = $Buttons/PlayButton
@onready var config_button: BaseUIButton = $Buttons/ConfigButton
@onready var exit_button: BaseUIButton = $Buttons/ExitButton
@onready var config_menu: ConfigMenu = $ConfigMenu


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	config_button.pressed.connect(_on_config_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause_menu"):
		toggle_visibility()
		
		if not visible:
			config_menu.hide_menu()
	
func _on_play_button_pressed() -> void:
	hide_menu()
	
func _on_config_button_pressed() -> void:
	config_menu.show()

func _on_exit_button_pressed() -> void:
	hide_menu()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
