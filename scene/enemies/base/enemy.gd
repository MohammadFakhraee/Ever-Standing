extends CharacterBody2D
class_name Enemy

@export var health_component: HealthComponent
@export var speed: float = 100
@export var dying_xp: int = 200


func _physics_process(_delta):
	move_and_slide()


func damage(attack: Attack):
	health_component.damage(attack)


func _on_health_component_damaged(_attack):
	pass


func _on_health_component_died():
	pass # Replace with function body.
