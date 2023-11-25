extends Node
class_name PlayerLevel

signal update_level_xp(current_level: int, xp_bar_current: int, xp_bar_max: int)

var current_level: int = 1
var next_level_xp: int = 1600
var current_xp: int = 400

func add_xp(xp: int):
	current_xp += xp
	if current_xp >= next_level_xp:
		while current_xp >= next_level_xp:
			_add_level()
			_update_next_level_xp()
			_emit_updated_xp()
	else:
		_emit_updated_xp()


func _emit_updated_xp():
	var level_xp = _calculate_level_xp(current_level)
	var xp_bar_max = next_level_xp - level_xp
	var xp_bar_current = current_xp - level_xp
	update_level_xp.emit(current_level, xp_bar_current, xp_bar_max)


func _calculate_level_xp(level: int) -> int:
	return pow(level * 20, 2)


func _add_level():
	current_level += 1


func _update_next_level_xp():
	next_level_xp = _calculate_level_xp(current_level + 1)


func set_level_and_xp(level: int, xp: int):
	self.current_level = level
	_update_next_level_xp()
	self.current_xp = xp
	_emit_updated_xp()
