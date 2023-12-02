extends PathFollow2D
class_name Weapons

enum Level { COMMON, RARE, EPIC, LEGENDARY }

@export var level: Level
@export var range: float
@export var damage: float
@export var base_knock_back_force: float = 50.0
@export var enemy_count: int = 1

var total_damage: float = 0
var total_damaged_enemies: int = 0
