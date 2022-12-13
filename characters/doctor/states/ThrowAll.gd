extends "res://doctor/characters/doctor/states/ThrowPotion.gd"

const PROJECTILE_SPEEDS = [4, 7, 10]

func _frame_6():
	if(data):
		dir_string = xy_to_dir(data.x, data.y)
		dir = Vector2(dir_string.x, dir_string.y).normalized()
	
	var p = 0
	while host.current_potions_number > 0:
		var potion = host.pop_potion()
		proj_x = str(PROJECTILE_SPEEDS[p] * dir.x)
		proj_y = str((PROJECTILE_SPEED * dir.y) + PROJECTILE_Y_OFFSET)
		throw(potion, proj_x, proj_y)
		p += 1
	
