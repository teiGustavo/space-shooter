class_name BaseLevel
extends Node2D


const spawn_area_min_x: float = 0

@export var next_scene: PackedScene
@export var level_description: LevelDescription
@export var ENEMY_INITIAL_SPEED: float = 4
@export var ENEMY_MAX_SPEED: float = 15
@export var ENEMY_SPEED_INCREASE: float = 0.2
@export var BACKGROUND_INITIAL_SPEED: float = 200
@export var BACKGROUND_MAX_SPEED: float = 400
@export var BACKGROUND_SPEED_INCREASE: float = 4

var survival_time: float = 0.0
var enemies_left: int
var enemies_alive: int = 0

@onready var hud: HUD = $HUD
@onready var player: Player = $Player
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var animated_background: AnimatedBackground = $AnimatedBackground
@onready var spawn_area_max_x: float = get_viewport().size.x
@onready var congratulations_label: Label = $CongratulationsLabel


func _ready() -> void:	
	enemies_left = level_description.horde_size
	
	PlayerVariables.reset()
	enemy_spawn_timer.timeout.connect(_on_enemy_spawn_timer_timeout)
	
func _physics_process(delta: float) -> void:
	survival_time += delta
	hud.elapsed_time = survival_time
	hud.enemies_left = enemies_left
	
	enemies_alive = get_tree().get_nodes_in_group('enemies').size()
	
	if enemies_alive == 0 and enemies_left == 0:	
		if not congratulations_label.visible:
			congratulations_label.show()
			congratulations_label.modulate.a = 0
			
			var tween = create_tween()
			tween.tween_property(congratulations_label, "modulate:a", 1, 1)
		
			await get_tree().create_timer(5).timeout
			TransitionManager.fade_to_scene(next_scene.resource_path)
	
	increase_background_speed()

func _on_enemy_spawn_timer_timeout() -> void:
	if enemies_left > 0:
		_spawn_enemy()
		enemies_left -= 1
		
func _spawn_enemy() -> void:
	var enemy: Enemy = level_description.enemy_variations.pick_random().instantiate()
	var random_x: float = randf_range(spawn_area_min_x, spawn_area_max_x) 
	var spawn_position: Vector2 = Vector2(random_x, -100)
	var speed = ENEMY_INITIAL_SPEED + (survival_time * ENEMY_SPEED_INCREASE)
	
	enemy.position = spawn_position
	enemy.direction = player.position
	enemy.speed = speed if speed < ENEMY_MAX_SPEED else ENEMY_MAX_SPEED
	
	enemy.collided_with_edge.connect(player.take_damage)
	
	add_child(enemy)
	
func increase_background_speed():
	var speed: float = BACKGROUND_INITIAL_SPEED + (survival_time * BACKGROUND_SPEED_INCREASE)
	animated_background.speed = speed if speed < BACKGROUND_MAX_SPEED else BACKGROUND_MAX_SPEED
