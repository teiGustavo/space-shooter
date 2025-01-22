class_name ConfigMenu
extends BasePopupMenu


@onready var mute_music_button: BaseUIButton = $Buttons/MuteMusicButton
@onready var mute_sounds_button: BaseUIButton = $Buttons/MuteSoundsButton
@onready var return_button: BaseUIButton = $Buttons/ReturnButton


func _ready() -> void:
	mute_music_button.toggled.connect(_on_mute_music_button_toggled)
	mute_sounds_button.toggled.connect(_on_mute_sounds_button_toggled)
	return_button.pressed.connect(_on_return_button_pressed)
	_set_buttons_state()

func _set_buttons_state() -> void:
	mute_sounds_button.set_pressed_no_signal(not GameState.volumes["sound"])
	mute_music_button.set_pressed_no_signal(not GameState.volumes["music"])

func _on_mute_sounds_button_toggled(toggled_on: bool) -> void:
	var volume: int = not int(toggled_on)
	
	SoundManager.set_sound_volume(volume)
	SoundManager.set_ui_sound_volume(volume)
	
	GameState.volumes["sound"] = volume
	GameState.volumes["ui"] = volume
	GameState.save_volumes()

func _on_mute_music_button_toggled(toggled_on: bool) -> void:
	var volume: int = not int(toggled_on)
	
	SoundManager.set_music_volume(volume)
	
	GameState.volumes["music"] = volume
	GameState.save_volumes()

func _on_return_button_pressed() -> void:
	hide()
	
