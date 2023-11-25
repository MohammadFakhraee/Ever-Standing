extends Node

signal health_change(amount: int)
signal died
signal update_player_xp(current_level: int, xp_bar_current: int, xp_bar_max: int)

var global_position: Vector2
var player_level: PlayerLevel = PlayerLevel.new()
var player_health: PlayerHealth = PlayerHealth.new()


func _ready():
	player_health.connect("health_change", _on_player_health_change)
	player_health.connect("died", _on_player_died)
	player_level.connect("update_level_xp", _on_player_level_updated_xp)
	# should be updated from database or file which helds current_level and current_xp
	player_level.set_level_and_xp(1, 400)


func hit(damage: int) -> void:
	var accepted_damage: int = damage # You can change accepted damage using powerups
	player_health.hit(accepted_damage)


func heal(amount: int) -> void:
	var accepted_heal = amount # You can change accepted amount using powerups
	player_health.heal(accepted_heal)


func _on_player_health_change(amount: int):
	health_change.emit(amount)


func _on_player_died():
	died.emit()


func _on_player_level_updated_xp(current_level: int, xp_bar_current: int, max_xp_max: int):
	update_player_xp.emit(current_level, xp_bar_current, max_xp_max)
