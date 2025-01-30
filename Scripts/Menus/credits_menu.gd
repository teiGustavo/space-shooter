class_name CreditsMenu
extends CanvasLayer


@onready var return_button: BaseUIButton = $Buttons/ReturnButton


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	
func _on_return_button_pressed() -> void:
	TransitionManager.fade_to_scene("res://Scenes/Menus/main_menu.tscn")
