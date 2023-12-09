extends Weapons
class_name Knife


func _on_attack():
	var attack_animation = create_tween()
	attack_animation.tween_property($HitArea, "position", Vector2(0.0, -100.0), 0.15)
	attack_animation.play()
	attack_animation.tween_property($HitArea, "position", Vector2.ZERO, 0.2)
	attack_animation.play()
	await attack_animation.finished
	finished_attack.emit()


func _on_hit_area_body_entered(body):
	if is_attacking:
		if body is Enemy and damaged_enemies < enemy_count:
			print(body)
			damaged_enemies += 1
			body.damage(create_attack_entity())


func create_attack_entity() -> Attack:
	var attack = Attack.new()
	attack.damage = self.damage
	attack.is_critical = false
	attack.nock_back_force = self.base_knock_back_force
	attack.nock_back_direction = Vector2.RIGHT
	return attack
