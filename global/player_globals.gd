extends Node

signal health_change(amount: int)
signal died

const INITIAL_MAX_HEALTH: int = 100

var health_amount: int = 100
var global_position: Vector2


func hit(damage: int) -> void:
	var accepted_damage: int = damage # You can change accepted damage using powerups
	health_amount -= accepted_damage
	if health_amount <= 0:
		died.emit()
	else:
		health_change.emit(health_amount)


func heal(amount: int) -> void:
	var accepted_heal = amount # You can change accepted amount using powerups
	health_amount += accepted_heal
	var player_max_health = max_health()
	if health_amount > max_health():
		health_amount = player_max_health
	health_change.emit(health_amount)


func max_health() -> int:
	return INITIAL_MAX_HEALTH # You can change max health using powerups
