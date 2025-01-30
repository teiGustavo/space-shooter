class_name HUD
extends CanvasLayer


@export var elapsed_time: float = 0
@export var enemies_left: int = 0

var elapsed_time_digits: Array[Node]
var enemies_left_digits: Array[Node]
var max_score_digits: int

@onready var numerals: Array[Resource] = GlobalFunctions.get_numerals()
@onready var score: Control = $Score
@onready var life_count_numeral: Sprite2D = $Life/LifeCountNumeral
@onready var score_digits: Array[Node] = $Score/Digits.get_children()
@onready var fps_count: Label = $FPS/FPSCount


func _ready() -> void:
	elapsed_time_digits = $ElapsedTime/Digits.get_children()
	elapsed_time_digits.erase($ElapsedTime/Digits/Separator)
	
	enemies_left_digits = $EnemiesLeft/Digits.get_children()
	
	max_score_digits = len(score_digits)

func _physics_process(_delta: float) -> void:
	_update_life_numeral()
	_update_score_display()
	_update_fps_display()
	_update_time_display()
	_update_enemies_left_display()

func _update_life_numeral() -> void:
	life_count_numeral.set_texture(numerals[PlayerVariables.life_count])

func _update_score_display()-> void:
	var score_string: String = str(PlayerVariables.score).pad_zeros(max_score_digits)
	var index: int = 0
	
	for child in score_digits:
		child.set_texture(numerals[int(score_string[index])])
		index += 1

func _update_fps_display() -> void:
	fps_count.text = str(int(Engine.get_frames_per_second()))

func _update_time_display() -> void:
	var total_elapsed_seconds: int = int(elapsed_time)
	var minutes: int = int(total_elapsed_seconds / 60.0)
	var seconds: int = int(total_elapsed_seconds % 60)
	
	if minutes > 59:
		return
	
	var elapsed_time_string: String = str(minutes).pad_zeros(2) + str(seconds).pad_zeros(2)
	var index: int = 0
	
	for child in elapsed_time_digits:
		child.set_texture(numerals[int(elapsed_time_string[index])])
		index += 1
		
func _update_enemies_left_display() -> void:	
	if enemies_left > 999:
		return
	
	var enemies_left_string: String = str(enemies_left).pad_zeros(3)
	var index: int = 0
	
	for child in enemies_left_digits:
		child.set_texture(numerals[int(enemies_left_string[index])])
		index += 1
