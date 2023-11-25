extends Node
class_name StateMachine

var state_list: Dictionary = {}

@export var initial_state: State
var current_state: State

@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready():
	for state in get_children():
		state.connect("transition", _on_state_transition)
		state.connect("animate_sprite", _on_state_animate_sprite)
		state_list[state.name] = state
	current_state = initial_state
	current_state.enter()


func _process(delta):
	current_state.update(delta)


func _physics_process(delta):
	current_state.physics_update(delta)


func _on_state_transition(state_name: String):
	if state_list.has(state_name):
		current_state.exit()
		current_state = state_list[state_name]
		current_state.enter()


func _on_state_animate_sprite(animation_name: String):
	animated_sprite.stop()
	animated_sprite.play(animation_name)
