extends State
class_name EnemyDied

@export var health_component: HealthComponent


func _init():
	state_name = "EnemyDied"


func _ready():
	health_component.connect("died", _on_health_component_died)


func enter():
	super.enter()
	speed = 0.0
	direction = Vector2.ZERO
	animate_sprite.emit("died")


func exit():
	super.exit()


func update(_delta: float):
	enemy.velocity = direction * speed


func _on_health_component_died():
	transition.emit(self.state_name)
	health_component.disconnect("died", _on_health_component_died)
