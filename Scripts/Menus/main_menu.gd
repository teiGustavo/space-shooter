class_name MainMenu
extends Node2D


const LEVEL_01: Resource = preload("res://Scenes/level_01.tscn")
const CURSOR: Resource = preload("res://Assets/PNG/UI/cursor.png")
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var play_button: TextureButton = $CanvasLayer/Buttons/PlayButton/TextureButton
@onready var config_button: TextureButton = $CanvasLayer/Buttons/ConfigButton/TextureButton
@onready var exit_button: TextureButton = $CanvasLayer/Buttons/ExitButton/TextureButton
@onready var credits_button: Button = $CanvasLayer/CreditsButton
@onready var config_menu: BasePopupMenu = $ConfigMenu
@onready var credits_menu: CanvasLayer = $CreditsMenu


func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR)
	play_button.pressed.connect(_on_start_button_pressed)
	config_button.pressed.connect(_on_config_button_pressed)
	exit_button.pressed.connect(_on_quit_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	enemy_spawn_timer.connect("timeout", _spawn_enemy)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_01)
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_config_button_pressed() -> void:
	config_menu.show()
	
func _on_credits_button_pressed() -> void:
	credits_menu.show()
	
func _spawn_enemy():
	GlobalFunctions.spawn_enemy(get_viewport().get_mouse_position(), self)
