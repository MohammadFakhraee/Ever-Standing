extends State
class_name EnemyWander

@export var notice_area: Area2D

@export var min_speed: float = 0.0
@export var max_speed: float = 0.0
@export var min_wander_time: float = 1.0
@export var max_wander_time: float = 1.0
@export var enemy: CharacterBody2D

var move_direction: Vector2
var speed: float = 10.0
var wander_timer: float


func enter():
	animate_sprite.emit("wander")
	if notice_area:
		notice_area.connect("body_entered", _on_notice_area_body_entered)
	set_speed_and_direction()
	start_wander_time()


func exit():
	if notice_area and notice_area.is_connected("body_entered", _on_notice_area_body_entered):
		notice_area.disconnect("body_entered", _on_notice_area_body_entered)


func update(delta: float):
	if wander_timer > 0: wander_timer -= delta
	else: on_wander_time_timeout()


func physics_update(_delta: float):
	if enemy:
		print("enemy wander physics")
		enemy.velocity = move_direction * speed


func set_speed_and_direction():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	speed = randf_range(min_speed,max_speed)


func start_wander_time():
	wander_timer = randf_range(min_wander_time,max_wander_time)


func _on_notice_area_body_entered(_body):
	transition.emit("EnemyChasing")


func on_wander_time_timeout():
	transition.emit("EnemyIdle")
