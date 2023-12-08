extends State
class_name EnemyAttack

@export var attack_area: AttackArea
@export var attack_exit_state: String = "EnemyChasing"
@export var firing_cooldown: float = 1.0

var cooldown_updater: float = firing_cooldown
var attack_player := false

func _init():
	state_name = "EnemyAttack"


func _ready():
	attack_area.connect("body_entered",_on_attack_area_body_entered)
	attack_area.connect("body_exited",_on_attack_area_body_exited)


func enter():
	super.enter()
	speed = 0.0
	direction = Vector2.ZERO
	attack_and_start_next_attack()


func exit():
	super.exit()


func update(delta: float):
	super.update(delta)
	if not attack_player:
		transition.emit(attack_exit_state)
	else:
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
	attack_player = false


func _on_attack_area_body_entered(_body):
	attack_player = true


func request_animation_flip():
	var attack_direction = (PlayerGlobals.global_position - enemy.global_position).normalized()
	if attack_direction.x < 0: animation_flip.emit(true, false)
	elif attack_direction.x > 0: animation_flip.emit(false, false)
