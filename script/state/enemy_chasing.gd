extends State
class_name EnemyChasing

@export var notice_area: NoticeArea
@export var notice_exit_state: String = "EnemyIdle"
@export var attack_area: AttackArea
@export var attack_enter_state: String = "EnemyAttack"
var is_player_noticed := true
var attack_player := false

func _init():
	state_name = "EnemyChasing"


func _ready():
	notice_area.connect("body_entered",_on_notice_area_body_entered)
	notice_area.connect("body_exited",_on_notice_area_body_exited)
	attack_area.connect("body_entered",_on_attack_area_body_entered)
	attack_area.connect("body_exited",_on_attack_area_body_exited)


func enter():
	super.enter()
	animate_sprite.emit("chase")
	look_at_player()


func exit():
	super.exit()


func update(delta):
	super.update(delta)
	if not is_player_noticed:
		transition.emit(notice_exit_state)
	elif attack_player: 
		transition.emit(attack_enter_state)
	else:
		look_at_player()


func physics_update(delta):
	super.physics_update(delta)
	if enemy:
		enemy.velocity = direction * speed


func look_at_player() -> void:
	direction = (PlayerGlobals.global_position - enemy.global_position).normalized()


func _on_attack_area_body_entered(_body):
	attack_player = true


func _on_attack_area_body_exited(_body):
	attack_player = false


func _on_notice_area_body_entered(_body):
	is_player_noticed = true


func _on_notice_area_body_exited(_body):
	is_player_noticed = false
