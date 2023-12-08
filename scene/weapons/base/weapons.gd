extends PathFollow2D
class_name Weapons

enum Level { COMMON, RARE, EPIC, LEGENDARY }

signal finished_attack

@export var level: Level
@export var weapon_range: float
@export var damage: float
@export var base_knock_back_force := 50.0
@export var enemy_count := 1

# Damaged enemies in each attack. 
# Should not exceed enemy_count
var damaged_enemies := 0

var is_attacking := false

var total_damage := 0.0
var total_damaged_enemies := 0


func _on_cooldown_timeout():
	is_attacking = true
	damaged_enemies = 0
	_on_attack()
	await finished_attack
	is_attacking = false
	$Cooldown.start()


func _on_attack() -> void:
	pass
