extends Node
class_name StateMachine

var state_list: Dictionary = {}

@export var animated_sprite: AnimatedSprite2D
@export var initial_state: State
var current_state: State

var is_paused: bool = false
var paused_state_transition: String

func _ready():
	for state in get_children():
		state.connect("transition", _on_state_transition)
		state.connect("animate_sprite", _on_state_animate_sprite)
		state_list[state.state_name] = state
	current_state = initial_state
	current_state.enter()


func _process(delta):
	if !is_paused:
		current_state.update(delta)


func _physics_process(delta):
	if !is_paused:
		current_state.physics_update(delta)


func _on_state_transition(state_name: String):
	if !is_paused:
		animated_sprite.stop()
		if state_list.has(state_name):
			current_state.exit()
			current_state = state_list[state_name]
			current_state.enter()
	else:
		paused_state_transition = state_name


func _on_state_animate_sprite(animation_name: String):
	animated_sprite.play(animation_name)


func pause():
	is_paused = true
	paused_state_transition = current_state.state_name


func play():
	is_paused = false
	if paused_state_transition:
		_on_state_transition(paused_state_transition)
