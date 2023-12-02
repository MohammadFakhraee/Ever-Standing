extends State
class_name EnemyChasing

@export var notice_area: NoticeArea
@export var notice_exit_state: String = "EnemyIdle"
@export var attack_area: AttackArea
@export var attack_enter_state: String = "EnemyAttack"


func _init():
	state_name = "EnemyChasing"


func enter():
	super.enter()
	animate_sprite.emit("chase")
	if notice_area:
		notice_area.connect("body_exited",_on_notice_area_body_exited)
	
	if attack_area:
		attack_area.connect("body_entered",_on_attack_area_body_entered)


func exit():
	super.exit()
	if notice_area and notice_area.is_connected("body_exited", _on_notice_area_body_exited):
		notice_area.disconnect("body_exited", _on_notice_area_body_exited)
	
	if attack_area and attack_area.is_connected("body_entered", _on_attack_area_body_entered):
		attack_area.disconnect("body_entered", _on_attack_area_body_entered)


func update(delta):
	super.update(delta)
	direction = (PlayerGlobals.global_position - enemy.global_position).normalized()


func physics_update(delta):
	super.physics_update(delta)
	if enemy:
		enemy.velocity = direction * speed


func _on_attack_area_body_entered(_body):
	transition.emit(attack_enter_state)


func _on_notice_area_body_exited(_body):
	transition.emit(notice_exit_state)
