extends CharacterBody2D
class_name Enemy

@export var speed: float = 100
@export var health: int = 30
@export var dying_xp: int = 200

func _physics_process(_delta):
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()
