class_name Level01
extends BaseLevel


@onready var tutorial_menu_1: CanvasLayer = $TutorialMenu1
@onready var tutorial_menu_2: CanvasLayer = $TutorialMenu2


func _ready() -> void:
	super._ready()
	
	var labels_tutorial_1: Array[Node] = tutorial_menu_1.get_children()
	var labels_tutorial_2: Array[Node] = tutorial_menu_2.get_children()
	
	tutorial_menu_1.show()
	
	for label in labels_tutorial_1:
		label.modulate.a = 0
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1, 1)

	await get_tree().create_timer(10).timeout
	
	for label in labels_tutorial_1:
		label.modulate.a = 1
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0, 1)
		
	tutorial_menu_2.show()
	
	for label in labels_tutorial_2:
		label.modulate.a = 0
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1, 1)

	await get_tree().create_timer(7).timeout
	
	for label in labels_tutorial_2:
		label.modulate.a = 1
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0, 1)
		
	enemy_spawn_timer.start()
	
