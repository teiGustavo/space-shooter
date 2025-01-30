class_name AnimatedBackground
extends Control

@export var texture: Texture2D
@export var speed: float = 200

@onready var background_1: TextureRect = $Background1 
@onready var background_2: TextureRect = $Background2
@onready var viewport_size: Vector2i = get_viewport().size


func _ready() -> void:
	background_1.texture = texture
	background_2.texture = texture
	background_1.size = viewport_size
	background_2.size = viewport_size
	background_1.position = Vector2(0, 0)
	background_2.position = Vector2(0, -viewport_size.y)

func _physics_process(delta: float) -> void:
	background_1.position.y += speed * delta
	background_2.position.y += speed * delta
	
	if background_1.position.y > viewport_size.y:
		background_1.position.y = background_2.position.y - viewport_size.y

	if background_2.position.y > viewport_size.y:
		background_2.position.y = background_1.position.y - viewport_size.y
