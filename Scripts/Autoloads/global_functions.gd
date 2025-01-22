extends Node


const ENEMY: Resource = preload("res://Prefabs/Characters/Enemies/enemy.tscn")
const spawn_area_min_x: float = 0
@onready var spawn_area_max_x: float = get_viewport().size.x


func play_sfx(sfx: Resource, increase_db: int = 0) -> void:
	var sound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	sound.stream = sfx
	get_tree().root.add_child(sound)
	sound.volume_db = increase_db
	sound.play()
	sound.finished.connect(sound.queue_free)

func get_numeral(number: int) -> Resource:
	var numeral: Resource
		
	match number:
		0:
			numeral = preload("res://Assets/PNG/UI/numeral0.png")
		1:
			numeral = preload("res://Assets/PNG/UI/numeral1.png")
		2:
			numeral = preload("res://Assets/PNG/UI/numeral2.png")
		3:
			numeral = preload("res://Assets/PNG/UI/numeral3.png")
		4:
			numeral = preload("res://Assets/PNG/UI/numeral4.png")
		5:
			numeral = preload("res://Assets/PNG/UI/numeral5.png")
		6:
			numeral = preload("res://Assets/PNG/UI/numeral6.png")
		7:
			numeral = preload("res://Assets/PNG/UI/numeral7.png")
		8:
			numeral = preload("res://Assets/PNG/UI/numeral8.png")
		9:
			numeral = preload("res://Assets/PNG/UI/numeral9.png")
		_:
			numeral = preload("res://Assets/PNG/UI/numeralX.png")
	
	return numeral

func get_numerals() -> Array[Resource]:
	var images: Array[Resource] = []
	
	for i in range(10):
		images.append(get_numeral(i))
		
	return images

func spawn_enemy(direction: Vector2, root: Node, speed: float = 4) -> void:
	var enemy: Node = ENEMY.instantiate()
	var random_x: float = randf_range(spawn_area_min_x, spawn_area_max_x) 
	var spawn_position: Vector2 = Vector2(random_x, 0)
	
	enemy.position = spawn_position
	enemy.direction = direction
	enemy.speed = speed
	
	root.add_child(enemy)

func destroy(obj) -> void:
	if not get_viewport().get_visible_rect().has_point(obj.position):
		obj.queue_free()
