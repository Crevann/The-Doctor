extends DefaultFireball

var knockback_direction
onready var hitbox = $HitboxExplosion

func _frame_0():
	host.screen_bump()
	var opponent_position = host.obj_local_center(host.creator.opponent)
	var opponent_position_vector = Vector2(opponent_position.x, opponent_position.y)
	var explosion_position_vector = Vector2(get_projectile_pos().x, get_projectile_pos().y)
	knockback_direction = (opponent_position_vector - explosion_position_vector).normalized()
	knockback_direction.x = abs(knockback_direction.x)
	
	if !host.creator.opponent.is_grounded():
		hitbox.dir_x = knockback_direction.x
		hitbox.dir_y = knockback_direction.y
		
func _frame_8():
	fizzle()
