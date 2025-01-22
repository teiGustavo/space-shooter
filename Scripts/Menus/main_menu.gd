class_name MainMenu
extends Node2D


const LEVEL_01: Resource = preload("res://Scenes/level_01.tscn")
const CURSOR: Resource = preload("res://Assets/PNG/UI/cursor.png")
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var play_button: TextureButton = $CanvasLayer/Buttons/PlayButton/TextureButton
@onready var config_button: TextureButton = $CanvasLayer/Buttons/ConfigButton/TextureButton
@onready var exit_button: TextureButton = $CanvasLayer/Buttons/ExitButton/TextureButton

func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR)
	play_button.pressed.connect(_on_start)
	exit_button.pressed.connect(_on_quit)
	enemy_spawn_timer.connect("timeout", _spawn_enemy)

func _physics_process(_delta: float) -> void:
	pass

func _on_start() -> void:
	get_tree().change_scene_to_packed(LEVEL_01)
	
func _on_quit() -> void:
	get_tree().quit()
	
func _spawn_enemy():
	GlobalFunctions.spawn_enemy(get_viewport().get_mouse_position(), self)
