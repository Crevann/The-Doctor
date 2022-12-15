extends "res://doctor/characters/doctor/states/base/PotionState.gd"

const PROJECTILE_SPEED = 8
const PROJECTILE_Y_OFFSET = -2

var dir_string
var dir
var proj_x = 0
var proj_y = 0

func _frame_6():
	if(data):
		dir_string = xy_to_dir(data.x, data.y)
		dir = Vector2(dir_string.x, dir_string.y)

	var potion = host.pop_potion()
	proj_x = str((PROJECTILE_SPEED * dir.x))
	proj_y = str((PROJECTILE_SPEED * dir.y) + PROJECTILE_Y_OFFSET)
	throw(potion, proj_x, proj_y)
