extends State
class_name EnemyWander

@export var notice_area: NoticeArea
@export var notice_enter_state: String = "EnemyChasing"
@export var wander_timeout_state: String = "EnemyWander"

@export var min_speed: float = 0.0
@export var max_speed: float = 0.0
@export var min_wander_time: float = 1.0
@export var max_wander_time: float = 1.0

var wander_timer: float


func _init():
	state_name = "EnemyWander"

func enter():
	super.enter()
	animate_sprite.emit("wander")
	if notice_area:
		notice_area.connect("body_entered", _on_notice_area_body_entered)
	set_speed_and_direction()
	start_wander_time()


func exit():
	super.exit()
	if notice_area and notice_area.is_connected("body_entered", _on_notice_area_body_entered):
		notice_area.disconnect("body_entered", _on_notice_area_body_entered)


func update(delta: float):
	super.update(delta)
	if wander_timer > 0: wander_timer -= delta
	else: on_wander_time_timeout()


func physics_update(delta: float):
	super.physics_update(delta)
	if enemy:
		enemy.velocity = direction * speed


func set_speed_and_direction():
	direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	speed = randf_range(min_speed,max_speed)


func start_wander_time():
	wander_timer = randf_range(min_wander_time,max_wander_time)


func _on_notice_area_body_entered(_body):
	transition.emit(notice_enter_state)


func on_wander_time_timeout():
	transition.emit(wander_timeout_state)
