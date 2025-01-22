class_name BaseUIButton
extends VBoxContainer


signal pressed
signal toggled(toggled_on: bool)

@export var custom_label: String = ""

@onready var label: Label = $Label
@onready var texture_button: BaseUITextureButton = $TextureButton


func _ready() -> void:
	texture_button.pressed.connect(pressed.emit)
	texture_button.toggled.connect(toggled.emit)
	
	if custom_label:
		label.text = custom_label

func set_pressed_no_signal(is_pressed: bool) -> void:
	texture_button.set_pressed_no_signal(is_pressed)
