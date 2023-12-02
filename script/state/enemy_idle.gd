extends State
class_name EnemyIdle

@export var notice_area: NoticeArea
@export var notice_enter_state: String = "EnemyChasing"
@export var idle_timeout_state: String = "EnemyWander"
@export var min_idle_time: float = 1.0
@export var max_idle_time: float = 1.0
var idle_timer: float


func _init():
	state_name = "EnemyIdle"

func enter():
	super.enter()
	speed = 0.0
	direction = Vector2.ZERO
	animate_sprite.emit("idle")
	notice_area.connect("body_entered", _on_notice_area_body_entered)
	start_idle_time()


func exit():
	super.exit()
	if notice_area and notice_area.is_connected("body_entered", _on_notice_area_body_entered):
		notice_area.disconnect("body_entered", _on_notice_area_body_entered)


func start_idle_time():
	idle_timer = randf_range(min_idle_time, max_idle_time)


func update(delta: float):
	super.update(delta)
	enemy.velocity = direction * speed
	if idle_timer > 0: idle_timer -= delta
	else: on_idle_time_timeout()


func physics_update(delta: float):
	super.physics_update(delta)
	pass


func _on_notice_area_body_entered(_body):
	transition.emit(notice_enter_state)


func on_idle_time_timeout():
	transition.emit(idle_timeout_state)
