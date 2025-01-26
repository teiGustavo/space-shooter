extends Node


const VOLUMES_FILE_PATH: String = "user://volumes.save"
const MUSIC: AudioStream = preload("res://Assets/Sounds/music.wav")

var volumes: Dictionary = {
	"ui": 1,
	"sound": 1,
	"music": 1,
	"ambient_sound": 1,
}


func _ready() -> void:
	set_all_audio_configs()
	
func save_volumes() -> void:
	JSONSaveManager.save(VOLUMES_FILE_PATH, volumes)

func load_volumes() -> void:
	var loaded_volumes: Variant = JSONSaveManager.load(VOLUMES_FILE_PATH)
		
	if loaded_volumes:
		volumes = loaded_volumes
			
func set_all_audio_configs() -> void:
	load_volumes()
	
	_config_audio_buses()
	_config_volumes()
	_play_backgorund_music()

func _config_audio_buses() -> void:
	SoundManager.set_default_ui_sound_bus("UI")
	SoundManager.set_default_music_bus("Music")
	SoundManager.set_default_sound_bus("Sound")
	SoundManager.set_default_ambient_sound_bus("Ambient Sound")
	
func _config_volumes() -> void:
	SoundManager.set_music_volume(volumes["music"])
	SoundManager.set_ui_sound_volume(volumes["ui"])
	SoundManager.set_sound_volume(volumes["sound"])
	SoundManager.set_ambient_sound_volume(volumes["ambient_sound"])

func _play_backgorund_music() -> void:
	SoundManager.play_music(MUSIC)
