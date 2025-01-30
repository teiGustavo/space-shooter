extends Node


const MIN_LIFE_COUNT: int = 0
const MAX_LIFE_COUNT: int = 5
const INITIAL_LIFE_COUNT: int = 3
const MAX_SCORE: int = 99999
const SCORE_INCREMENT: int = 100
const SCORE_DECREMENT: int = 300

var life_count: int = 3
var score: int = 0
var total_alive_time: float = 0


func has_lives_left() -> bool:
	return true if life_count > MIN_LIFE_COUNT else false

func decrease_life(count: int = 1) -> void:
	if has_lives_left():
		life_count -= count
	
func increase_life(count: int = 1) -> void:
	if life_count < MAX_LIFE_COUNT:
		life_count += count

func increase_score(count: int = SCORE_INCREMENT) -> void:
	if (score + count) < MAX_SCORE:
		score += count
	else:
		score = MAX_SCORE

func decrease_score(count: int = SCORE_DECREMENT) -> void:
	if (score - count) > 0:
		score -= count
	else:
		score = 0
		
func reset() -> void:
	life_count = INITIAL_LIFE_COUNT
	score = 0
	total_alive_time = 0
