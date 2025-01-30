class_name Level01
extends Node2D


const spawn_area_min_x: float = 0

@export var all_level_descriptions: ResourceGroup = load(
	"res://Data/Levels/level_descriptions.tres"
)
@export var ENEMY_INITIAL_SPEED: float = 4
@export var ENEMY_MAX_SPEED: float = 15
@export var ENEMY_SPEED_INCREASE: float = 0.2
@export var BACKGROUND_INITIAL_SPEED: float = 200
@export var BACKGROUND_MAX_SPEED: float = 400
@export var BACKGROUND_SPEED_INCREASE: float = 4

var survival_time: float = 0.0
var level_descriptions: Array[LevelDescription]
@export var level_description: LevelDescription

@onready var hud: CanvasLayer = $HUD
@onready var player: Player = $Player
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var animated_background: Control = $AnimatedBackground
@onready var spawn_area_max_x: float = get_viewport().size.x


func _ready() -> void:
	if not all_level_descriptions:
		push_error("Please enter the level descriptions ResourceGroup manually!")
	else:
		level_descriptions = Array(
			all_level_descriptions.load_all(),
			TYPE_OBJECT,
			"Resource",
			LevelDescription
		)
	
	PlayerVariables.reset()
	enemy_spawn_timer.timeout.connect(_spawn_enemy)
	
func _physics_process(delta: float) -> void:
	survival_time += delta
	hud.elapsed_time = survival_time
	
	increase_background_speed()

func _spawn_enemy() -> void:
	var enemy: Enemy = level_description.enemy_variations.pick_random().instantiate()
	var random_x: float = randf_range(spawn_area_min_x, spawn_area_max_x) 
	var spawn_position: Vector2 = Vector2(random_x, 0)
	var speed = ENEMY_INITIAL_SPEED + (survival_time * ENEMY_SPEED_INCREASE)
	
	enemy.position = spawn_position
	enemy.direction = player.position
	enemy.speed = speed if speed < ENEMY_MAX_SPEED else ENEMY_MAX_SPEED
	
	enemy.collided_with_edge.connect(player.take_damage)
	
	add_child(enemy)
	
func increase_background_speed():
	var speed: float = BACKGROUND_INITIAL_SPEED + (survival_time * BACKGROUND_SPEED_INCREASE)
	animated_background.speed = speed if speed < BACKGROUND_MAX_SPEED else BACKGROUND_MAX_SPEED
