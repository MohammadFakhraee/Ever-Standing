extends State
class_name EnemyIdle

@export var notice_area: Area2D
@export var min_idle_time: float = 1.0
@export var max_idle_time: float = 1.0
@export var enemy: CharacterBody2D
var idle_timer: float


func enter():
	animate_sprite.emit("idle")
	if notice_area:
		notice_area.connect("body_entered", _on_notice_area_body_entered)
	start_idle_time()


func exit():
	if notice_area and notice_area.is_connected("body_entered", _on_notice_area_body_entered):
		notice_area.disconnect("body_entered", _on_notice_area_body_entered)


func start_idle_time():
	idle_timer = randf_range(min_idle_time, max_idle_time)


func update(delta: float):
	if enemy:
		enemy.velocity = Vector2.ZERO
	if idle_timer > 0: idle_timer -= delta
	else: on_idle_time_timeout()


func physics_update(_delta: float):
	pass


func _on_notice_area_body_entered(_body):
	transition.emit("EnemyChasing")


func on_idle_time_timeout():
	transition.emit("EnemyWander")
