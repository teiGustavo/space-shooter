class_name Enemy
extends CharacterBody2D


const DEFAULT_SPEED: float = 4
var direction: Vector2
var need: Vector2
@export var speed: float = DEFAULT_SPEED

func _ready() -> void:
	add_to_group("enemies")
	look_at(direction)
	need = position.direction_to(direction)

func _physics_process(_delta: float) -> void:
	position += need * speed
	
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()
		
		if not get_parent().name == 'Menu':
			var player = get_parent().get_node("Player")
			
			if player:
				player.take_damage()
