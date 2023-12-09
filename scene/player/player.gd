extends CharacterBody2D

@export var base_speed: float = 250.0
var speed: float = 0.0
var direction: Vector2

func _physics_process(_delta):
	PlayerGlobals.global_position = global_position
	
	speed = base_speed # You can add any speed enhancement here
	direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
	
	var sorted_enemies = get_enemies_sorted_by_distance()
	for i in $WeaponsPath.get_child_count():
		if sorted_enemies[0]:
			var path_follow = $WeaponsPath.get_child(i)
			var enemy = sorted_enemies[0]
			self.global_position.angle()
			var enemy_angle: float = (enemy.global_position - self.global_position).angle()
			path_follow.progress_ratio = enemy_angle / (2 * PI)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if velocity.length() == 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")
	
	move_and_slide()


func get_enemies_sorted_by_distance() -> Array[Node]:
	var all_enemies : Array[Node] = get_tree().get_nodes_in_group("Enemy")
	all_enemies.sort_custom(_on_enemies_sorting_callback)
	return all_enemies


func _on_enemies_sorting_callback(a: Enemy, b: Enemy) -> bool:
	var dist_to_a = self.global_position.distance_to(a.global_position)
	var dist_to_b = self.global_position.distance_to(b.global_position)
	return dist_to_a < dist_to_b


