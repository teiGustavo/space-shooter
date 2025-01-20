extends Node2D


# Velocidade de movimento da nave (px/frame = speed/delta)
var speed: float = 300
const LASER = preload("res://Prefabs/laser.tscn")
@onready var point_laser: Marker2D = $Sprite2D/PointLaser
var mouse_position: Vector2
var time_since_last_shot: float 
const fire_rate: float = 0.13

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var velocity: Vector2 = direction * speed * delta
	
	mouse_position = get_viewport().get_mouse_position()
	look_at(mouse_position)
	
	time_since_last_shot += delta
	
	if Input.is_action_just_pressed("single_shot"):
		shoot()
		
	if Input.is_action_just_pressed("burst_shot"):
		shoot()
		
	if Input.is_action_pressed("multi_shot") and time_since_last_shot >= fire_rate:
		shoot()
		time_since_last_shot = 0
	
	position += velocity

func shoot():
	var laser = LASER.instantiate()
	
	laser.position = point_laser.global_position
	laser.direction = mouse_position
	laser.rotation_degrees = 0
	
	laser.look_at(mouse_position)
	add_sibling(laser)
