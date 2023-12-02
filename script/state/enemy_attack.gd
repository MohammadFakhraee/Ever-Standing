extends State
class_name EnemyAttack

@export var attack_area: AttackArea
@export var attack_exit_state: String = "EnemyChasing"
@export var firing_cooldown: float = 1.0

var cooldown_updater: float = firing_cooldown


func _init():
	state_name = "EnemyAttack"

func enter():
	super.enter()
	speed = 0.0
	direction = Vector2.ZERO
	if attack_area:
		attack_area.connect("body_exited",_on_attack_area_body_exited)
	attack_and_start_next_attack()


func exit():
	super.exit()
	if attack_area and attack_area.is_connected("body_exited",_on_attack_area_body_exited):
		attack_area.disconnect("body_exited",_on_attack_area_body_exited)


func update(delta: float):
	super.update(delta)
	if cooldown_updater > 0: cooldown_updater -= delta
	else: attack_and_start_next_attack()


func physics_update(delta):
	super.physics_update(delta)
	if enemy:
		enemy.velocity = direction * speed


func attack_and_start_next_attack():
	attack()
	start_next_attack()


func attack():
	animate_sprite.emit("attack")
	pass # call attack method on enemy (or attack component)


func start_next_attack():
	cooldown_updater = firing_cooldown

func _on_attack_area_body_exited(_body):
	transition.emit(attack_exit_state)


func request_animation_flip():
	var attack_direction = (PlayerGlobals.global_position - enemy.global_position).normalized()
	if attack_direction.x < 0: animation_flip.emit(true, false)
	elif attack_direction.x > 0: animation_flip.emit(false, false)
