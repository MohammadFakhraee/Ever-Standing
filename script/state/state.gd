extends Node
class_name State

signal transition(new_state_name: String)
signal animate_sprite(animation_name: String)
signal animation_flip(should_flip_h: bool, should_flip_v: bool)

@export var enemy: Enemy
@export var speed: float



var direction: Vector2 = Vector2.ZERO
var state_name: String

func enter() -> void:
	pass


func exit() -> void:
	pass
	
	
func update(_delta: float) -> void:
	pass
	
	
func physics_update(_delta: float) -> void:
	request_animation_flip()
	pass


func request_animation_flip():
	if enemy.velocity.x < 0: animation_flip.emit(true, false)
	elif enemy.velocity.x > 0: animation_flip.emit(false, false)
