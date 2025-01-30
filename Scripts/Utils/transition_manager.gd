extends CanvasLayer


var scene_path: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func fade_to_scene(path: String) -> void:
	animation_player.play("fade")
	scene_path = path

func change_scene() -> void:
	get_tree().change_scene_to_file(scene_path)
