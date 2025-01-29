class_name BaseUIButton
extends VBoxContainer


signal pressed
signal toggled(toggled_on: bool)

const BUTTON_CLICK: AudioStreamWAV = preload("res://Assets/Sounds/button-click.wav")

@export var custom_label: String = ""

@onready var label: Label = $Label
@onready var texture_button: BaseUITextureButton = $TextureButton


func _ready() -> void:
	texture_button.pressed.connect(_on_button_pressed)
	texture_button.toggled.connect(_on_button_toggled)
	
	if custom_label:
		label.text = custom_label

func set_pressed_no_signal(is_pressed: bool) -> void:
	texture_button.set_pressed_no_signal(is_pressed)

func _play_sound() -> void:
	SoundManager.play_ui_sound(BUTTON_CLICK)

func _on_button_pressed() -> void:
	pressed.emit()
	_play_sound()
	
func _on_button_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)
	_play_sound()
