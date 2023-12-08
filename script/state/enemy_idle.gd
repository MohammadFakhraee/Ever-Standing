extends State
class_name EnemyIdle

@export var notice_area: NoticeArea
@export var notice_enter_state: String = "EnemyChasing"
@export var idle_timeout_state: String = "EnemyWander"
@export var min_idle_time: float = 1.0
@export var max_idle_time: float = 1.0
var idle_timer: float
var is_player_noticed := false

func _init():
	state_name = "EnemyIdle"


func _ready():
	notice_area.connect("body_entered", _on_notice_area_body_entered)
	notice_area.connect("body_exited", _on_notice_area_body_exited)


func enter():
	super.enter()
	speed = 0.0
	direction = Vector2.ZERO
	enemy.velocity = direction * speed
	animate_sprite.emit("idle")
	start_idle_time()


func exit():
	super.exit()


func start_idle_time():
	idle_timer = randf_range(min_idle_time, max_idle_time)


func update(delta: float):
	super.update(delta)
	if is_player_noticed: 
		transition.emit(notice_enter_state)
	else:
		if idle_timer > 0: idle_timer -= delta
		else: on_idle_time_timeout()


func physics_update(delta: float):
	super.physics_update(delta)
	pass


func _on_notice_area_body_entered(_body):
	is_player_noticed = true


func _on_notice_area_body_exited(_body):
	is_player_noticed = false


func on_idle_time_timeout():
	transition.emit(idle_timeout_state)
