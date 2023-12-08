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
var is_player_noticed := false

func _init():
	state_name = "EnemyWander"


func _ready():
	notice_area.connect("body_entered", _on_notice_area_body_entered)
	notice_area.connect("body_exited", _on_notice_area_body_exited)


func enter():
	super.enter()
	animate_sprite.emit("wander")
	set_speed_and_direction()
	start_wander_time()


func exit():
	super.exit()


func update(delta: float):
	super.update(delta)
	if is_player_noticed: 
		transition.emit(notice_enter_state)
	else: 
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
	is_player_noticed = true


func _on_notice_area_body_exited(_body):
	is_player_noticed = false


func on_wander_time_timeout():
	transition.emit(wander_timeout_state)
