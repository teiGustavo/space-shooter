class_name ExplosionEffect
extends GPUParticles2D


func _ready() -> void:
	emitting = true
	
	await get_tree().create_timer(lifetime + 0.1).timeout
	queue_free()
