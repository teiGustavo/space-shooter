extends Area2D


const SFX_LASER_1: Resource = preload("res://Assets/Bonus/sfx_laser1.ogg")
var direction: Vector2
var need: Vector2
@export var speed: float = 45


func _ready() -> void:
	need = position.direction_to(direction)
	look_at(direction)
	connect("body_entered", _on_body_entered)
	GlobalFunctions.play_sfx(SFX_LASER_1, 10)
	
func _physics_process(_delta: float) -> void:
	position += need * speed
	
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
		body.queue_free()
		PlayerVariables.increase_score()
