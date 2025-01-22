extends Node2D

const ENEMY: Resource = preload("res://Prefabs/Characters/Enemies/enemy.tscn")
const LIFE_POWERUP = preload("res://Prefabs/PowerUps/life_powerup.tscn")
@onready var hud: CanvasLayer = $HUD
@onready var player: CharacterBody2D = $Player
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var life_powerup_spawn_timer: Timer = $LifePowerupSpawnTimer
@onready var animated_background: Control = $AnimatedBackground
@onready var spawn_area_max_x: float = get_viewport().size.x
@export var PLAYER_INITIAL_LIFE_COUNT: int = 3
@export var ENEMY_INITIAL_SPEED: float = 4
@export var ENEMY_MAX_SPEED: float = 15
@export var ENEMY_SPEED_INCREASE: float = 0.2
@export var BACKGROUND_INITIAL_SPEED: float = 200
@export var BACKGROUND_MAX_SPEED: float = 400
@export var BACKGROUND_SPEED_INCREASE: float = 4
const spawn_area_min_x: float = 0
var survival_time: float = 0.0


func _ready() -> void:
	PlayerVariables.life_count = PLAYER_INITIAL_LIFE_COUNT
	PlayerVariables.score = 0
	enemy_spawn_timer.timeout.connect(_spawn_enemy)
	life_powerup_spawn_timer.timeout.connect(_spawn_life_powerup)
	
func _physics_process(delta: float) -> void:
	survival_time += delta
	hud.elapsed_time = survival_time
	increase_background_speed()
	
	if PlayerVariables.life_count < PLAYER_INITIAL_LIFE_COUNT:
		if life_powerup_spawn_timer.is_stopped():
			life_powerup_spawn_timer.start()
	else:
		life_powerup_spawn_timer.stop()

func _spawn_enemy() -> void:
	var enemy: Node = ENEMY.instantiate()
	var random_x: float = randf_range(spawn_area_min_x, spawn_area_max_x) 
	var spawn_position: Vector2 = Vector2(random_x, 0)
	var speed = ENEMY_INITIAL_SPEED + (survival_time * ENEMY_SPEED_INCREASE)
	
	enemy.position = spawn_position
	enemy.direction = player.position
	enemy.speed = speed if speed < ENEMY_MAX_SPEED else ENEMY_MAX_SPEED
	
	add_child(enemy)
	
func increase_background_speed():
	var speed: float = BACKGROUND_INITIAL_SPEED + (survival_time * BACKGROUND_SPEED_INCREASE)
	animated_background.speed = speed if speed < BACKGROUND_MAX_SPEED else BACKGROUND_MAX_SPEED

func _spawn_life_powerup():
	var life_powerup: Node = LIFE_POWERUP.instantiate()
	var random_x: float = randf_range(spawn_area_min_x + 50, spawn_area_max_x - 50) 
	var spawn_position: Vector2 = Vector2(random_x, 0)
	
	life_powerup.position = spawn_position
	life_powerup.direction = Vector2.DOWN
	
	add_child(life_powerup)
