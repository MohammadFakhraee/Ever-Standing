extends State
class_name EnemyAttack

@export var attack_area: Area2D
@export var firing_cooldown: float = 1.0

var cooldown_updater: float = firing_cooldown


func _init():
	state_name = "EnemyAttack"

func enter():
	speed = 0.0
	direction = Vector2.ZERO
	animate_sprite.emit("attack")
	if attack_area:
		attack_area.connect("body_exited",_on_attack_area_body_exited)
	start_next_attack()


func exit():
	if attack_area and attack_area.is_connected("body_exited",_on_attack_area_body_exited):
		attack_area.disconnect("body_exited",_on_attack_area_body_exited)


func update(delta: float):
	if enemy:
		enemy.velocity = direction * speed
	if cooldown_updater > 0: cooldown_updater -= delta
	else: attack_and_start_next_attack()


func attack_and_start_next_attack():
	attack()
	start_next_attack()


func attack():
	pass # call attack method on enemy (or attack component)


func start_next_attack():
	cooldown_updater = firing_cooldown

func _on_attack_area_body_exited(_body):
	transition.emit("EnemyChasing")
