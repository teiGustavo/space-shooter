class_name Level01
extends BaseLevel


@onready var tutorial_menu: CanvasLayer = $TutorialMenu


func _ready() -> void:
	super._ready()
	
	var labels: Array[Node] = tutorial_menu.get_children()
	
	tutorial_menu.show()
	
	for label in labels:
		label.modulate.a = 0
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1, 1)

	await get_tree().create_timer(7).timeout
	
	for label in labels:
		label.modulate.a = 1
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0, 1)
	
	enemy_spawn_timer.start()
	
