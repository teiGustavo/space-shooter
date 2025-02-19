class_name Laser
extends Area2D


const SFX_LASER_1: Resource = preload("res://Assets/Bonus/sfx_laser1.ogg")

@export var speed: float = 45

var direction: Vector2
var need: Vector2


func _ready() -> void:
	need = position.direction_to(direction)
	look_at(direction)
	connect("body_entered", _on_body_entered)
	SoundManager.play_sound(SFX_LASER_1)
	
func _physics_process(_delta: float) -> void:
	position += need * speed
	
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
		body.destroyed_by_player.emit()
		body.destroy()
		PlayerVariables.increase_score()
