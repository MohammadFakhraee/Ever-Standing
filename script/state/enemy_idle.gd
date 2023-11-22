extends State
class_name EnemyIdle

@export var notice_area: Area2D
@export var rand_idle_time_range: Range = Range.new()

var idle_timer: float


func enter():
	if notice_area:
		notice_area.connect("body_entered", _on_notice_area_body_entered)
	start_idle_time()


func exit():
	if notice_area and notice_area.is_connected("body_entered", _on_notice_area_body_entered):
		notice_area.disconnect("body_entered", _on_notice_area_body_entered)


func start_idle_time():
	var min_time = rand_idle_time_range.min_value
	var max_time = rand_idle_time_range.max_value
	idle_timer = randf_range(min_time, max_time)


func update(delta: float):
	if idle_timer > 0: idle_timer -= delta
	else: on_idle_time_timeout()


func physics_update(_delta: float):
	pass


func _on_notice_area_body_entered(_body):
	transition.emit("EnemyChasing")


func on_idle_time_timeout():
	transition.emit("EnemyWander")
