extends CharacterBody2D

const LASER: Resource = preload("res://Prefabs/laser.tscn")
const SFX_LOSE: Resource = preload("res://Assets/Bonus/sfx_lose.ogg")
const SFX_SHIELD_UP: Resource = preload("res://Assets/Bonus/sfx_shieldUp.ogg")
const SCREEN_MARGIN: int = 60
@onready var point_laser: Marker2D = $CollisionShape2D/PlayerShip2Blue/Marker2D
@onready var multi_shot_cooldown_timer: Timer = $MultiShotCooldownTimer
@onready var burst_shot_cooldown_timer: Timer = $BurstShotCooldownTimer
@export var speed: float = 300
@export var multi_shot_cooldown: float = 0.1
@export var burst_shot_cooldown: float = 0.11
@export var shots_per_burst: int = 3
@export var IMMORTAL: bool = false
@onready var viewport_size: Vector2 = get_viewport().size
@onready var flames: Control = $CollisionShape2D/Flames
var shots_fired: int = 0
var can_shot = true
var mouse_position: Vector2
var time_since_last_shot: float 
var last_collision: KinematicCollision2D


func _ready() -> void:
	multi_shot_cooldown_timer.wait_time = multi_shot_cooldown
	multi_shot_cooldown_timer.timeout.connect(_reset_cooldown)
	
	burst_shot_cooldown_timer.wait_time = burst_shot_cooldown
	burst_shot_cooldown_timer.timeout.connect(_next_shot)
	
func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * speed
	
	if direction.length() > 0:
		flames.visible = true
	else:
		flames.visible = false
	
	mouse_position = get_viewport().get_mouse_position()
	look_at(mouse_position)
	
	move_and_slide()
	clamp_position(viewport_size)
	
	detect_shot()
	detect_slide_collision()

func clamp_position(screen_size: Vector2) -> void:
	position.x = clamp(position.x, SCREEN_MARGIN, screen_size.x - SCREEN_MARGIN)
	position.y = clamp(position.y, SCREEN_MARGIN, screen_size.y - SCREEN_MARGIN)
	
func _reset_cooldown() -> void:
	can_shot = true
	
func _next_shot() -> void:
	if shots_fired < shots_per_burst:
		shots_fired += 1
		burst_shot_cooldown_timer.start()
		shoot()
	else:
		_reset_cooldown()

func detect_shot() -> void:
	if Input.is_action_just_pressed("single_shot") and can_shot:
		shoot()
		
	if Input.is_action_just_pressed("burst_shot") and can_shot:
		can_shot = false
		shots_fired = 0
		_next_shot()
		
	if Input.is_action_pressed("multi_shot") and can_shot:
		can_shot = false
		multi_shot_cooldown_timer.start()
		shoot()
		
	if Input.is_action_pressed("ui_home"):
		shoot()

func shoot() -> void:
	var laser: Node = LASER.instantiate()

	laser.position = point_laser.global_position
	laser.direction = mouse_position

	add_sibling(laser)
	
func take_damage():
	GlobalFunctions.play_sfx(SFX_LOSE, 10)
	PlayerVariables.decrease_score()
	
	if not IMMORTAL:
		PlayerVariables.decrease_life()
		
		if PlayerVariables.life_count == 0:
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func increase_life():
	GlobalFunctions.play_sfx(SFX_SHIELD_UP)
	PlayerVariables.increase_life()

func detect_slide_collision() -> void:
	last_collision = get_last_slide_collision()
	
	if last_collision:
		var collider = last_collision.get_collider()
		
		if collider.is_in_group("enemies"):
			collider.queue_free()
			take_damage()
			
		if collider.is_in_group("life_powerup"):
			collider.queue_free()
			increase_life()
