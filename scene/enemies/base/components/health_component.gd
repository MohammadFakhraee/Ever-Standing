extends Node
class_name HealthComponent

signal died
signal damaged(attack: Attack)

@export var max_health: float
var health: float

var accepting_damage := true

func _ready():
	health = max_health


func damage(attack: Attack):
	if accepting_damage:
		health -= attack.damage
		damaged.emit(attack)
		if health <= 0:
			accepting_damage = false
			died.emit()
