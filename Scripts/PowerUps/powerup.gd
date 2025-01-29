class_name PowerUp
extends CharacterBody2D


const DEFAULT_SPEED: float = 1

@export var speed: float = DEFAULT_SPEED

var direction: Vector2
var need: Vector2


func _ready() -> void:
	add_to_group("life_powerup")
	need = direction

func _physics_process(_delta: float) -> void:
	position += need * speed
	
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()
