extends CharacterBody2D

@export var speed: float = 250.0
var direction: Vector2

func _process(_delta):
	PlayerGlobals.global_position = global_position
	
	direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if velocity.length() == 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")
	
	move_and_slide()
	
	
