extends State
class_name EnemyChasing

@export var notice_area: Area2D
@export var attack_area: Area2D
@export var enemy: CharacterBody2D

@export var speed: float = 20.0
var direction: Vector2


func enter():
	animate_sprite.emit("chase")
	if notice_area:
		notice_area.connect("body_exited",_on_notice_area_body_exited)
	
	if attack_area:
		attack_area.connect("body_entered",_on_attack_area_body_entered)


func exit():
	if notice_area and notice_area.is_connected("body_exited", _on_notice_area_body_exited):
		notice_area.disconnect("body_exited", _on_notice_area_body_exited)
	
	if attack_area and attack_area.is_connected("body_entered", _on_attack_area_body_entered):
		attack_area.disconnect("body_entered", _on_attack_area_body_entered)


func update(_delta):
	direction = (PlayerGlobals.global_position - enemy.global_position).normalized()


func physics_update(_delta):
	if enemy:
		enemy.velocity = direction * speed


func _on_attack_area_body_entered(_body):
	transition.emit("EnemyAttack")


func _on_notice_area_body_exited(_body):
	transition.emit("EnemyIdle")
