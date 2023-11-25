extends Node
class_name PlayerHealth

signal health_change(amount: int)
signal died

const INITIAL_MAX_HEALTH: int = 100

var health_amount: int = 100


func hit(damage: int) -> void:
	health_amount -= damage
	
	if health_amount < 0:
		health_amount = 0
	health_change.emit(health_amount)
	
	if health_amount == 0:
		died.emit()


func heal(amount: int) -> void:
	health_amount += amount
	var player_max_health = max_health()
	if health_amount > max_health():
		health_amount = player_max_health
	health_change.emit(health_amount)


func max_health() -> int:
	return INITIAL_MAX_HEALTH # You can change max health using powerups

