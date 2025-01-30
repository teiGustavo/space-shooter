extends Node


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

# Função utilitária para UI's
func spawn_enemy(
	enemy_variations: Array[PackedScene], 
	direction: Vector2, 
	root: Node, 
	speed: float = 4
) -> void:
	if not enemy_variations:
		push_warning('Enemy variations is empty.')
		return
	
	var enemy: Enemy = enemy_variations.pick_random().instantiate()
	var random_x: float = randf_range(0, get_viewport().size.x) 
	var spawn_position: Vector2 = Vector2(random_x, 0)
	
	enemy.position = spawn_position
	enemy.direction = direction
	enemy.speed = speed
	
	root.add_child(enemy)
