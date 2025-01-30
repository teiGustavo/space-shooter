class_name Enemy
extends CharacterBody2D


signal collided_with_edge
signal destroyed_by_player

const LIFE_POWERUP: Resource = preload("res://Prefabs/PowerUps/life_powerup.tscn")
const EXPLOSION_EFFECT: Resource = preload("res://Prefabs/Utils/Effects/explosion_effect.tscn")
const DEFAULT_SPEED: float = 4

var direction: Vector2
var need: Vector2

@export var speed: float = DEFAULT_SPEED


func _ready() -> void:
	add_to_group("enemies")
	look_at(direction)
	need = position.direction_to(direction)
	
	destroyed_by_player.connect(_on_destroyed_by_player)

func _physics_process(_delta: float) -> void:
	position += need * speed
	
	# Inimigo é eliminado caso passe do limite da tela
	if not get_viewport().get_visible_rect().has_point(position) and position.y > 0:
		queue_free()
		collided_with_edge.emit()

func destroy() -> void:
	var explosion: ExplosionEffect = EXPLOSION_EFFECT.instantiate()
	
	explosion.global_position = global_position
	get_parent().add_child.call_deferred(explosion)
	
	queue_free()

func _on_destroyed_by_player() -> void:
	if PlayerVariables.life_count == PlayerVariables.MAX_LIFE_COUNT:
		return
	
	# Porcentagem de spawnar um power-up
	if randi_range(1, 20) == 3:
		_spawn_powerup()

func _spawn_powerup():
	var powerup: Node = LIFE_POWERUP.instantiate()
	var spawn_position: Vector2 = global_position
	
	powerup.position = spawn_position
	powerup.direction = Vector2.DOWN
	
	get_parent().add_child.call_deferred(powerup)
