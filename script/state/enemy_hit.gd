extends State
class_name EnemyHit

@export var health_component: HealthComponent
@export var nock_back_time: float = 0.5
@export var fallback_state_name: String = "EnemyIdle"


func _init():
	state_name = "EnemyHit"


func _ready():
	health_component.connect("damaged", _on_health_component_damaged)
	health_component.connect("died", _on_health_component_died)


func enter():
	super.enter()
	animate_sprite.emit("died")


func exit():
	super.exit()


func update(delta: float):
	super.update(delta)
	if nock_back_time > 0: nock_back_time -= delta
	else: transition.emit(fallback_state_name)


func physics_update(delta: float):
	super.physics_update(delta)
	enemy.velocity = direction.normalized() * speed


func _on_health_component_damaged(attack: Attack):
	self.speed = attack.nock_back_force
	self.direction = attack.nock_back_direction
	transition.emit(self.state_name)


func _on_health_component_died():
	health_component.disconnect("damaged", _on_health_component_damaged)
	health_component.disconnect("died", _on_health_component_died)


func request_animation_flip():
	pass
