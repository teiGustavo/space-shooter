class_name Enemy
extends CharacterBody2D


signal collided_with_edge

const EXPLOSION_EFFECT: Resource = preload("res://Prefabs/Utils/Effects/explosion_effect.tscn")
const DEFAULT_SPEED: float = 4

var direction: Vector2
var need: Vector2

@export var speed: float = DEFAULT_SPEED


func _ready() -> void:
	add_to_group("enemies")
	look_at(direction)
	need = position.direction_to(direction)
	
	tree_exiting.connect(_on_tree_exiting)

func _physics_process(_delta: float) -> void:
	position += need * speed
	
	# Inimigo é eliminado caso passe do limite da tela
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()
		collided_with_edge.emit()

func destroy() -> void:
	var explosion: ExplosionEffect = EXPLOSION_EFFECT.instantiate()
	
	explosion.global_position = global_position
	get_parent().add_child.call_deferred(explosion)
	
	queue_free()

func _on_tree_exiting() -> void:
	destroy()
