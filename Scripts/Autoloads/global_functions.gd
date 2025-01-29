extends Node


const spawn_area_min_x: float = 0
@onready var spawn_area_max_x: float = get_viewport().size.x


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

func destroy(obj) -> void:
	if not get_viewport().get_visible_rect().has_point(obj.position):
		obj.queue_free()
