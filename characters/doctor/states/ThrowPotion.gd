extends CharacterState

const POTIONS_PROJECTILES = [preload("res://doctor/characters/doctor/projectiles/plague_potion/PlaguePotion.tscn"),
							preload("res://doctor/characters/doctor/projectiles/boom_potion/BoomPotion.tscn")]

const PROJECTILE_X = 0
const PROJECTILE_Y = -16
const PROJECTILE_SPEED = 8
const PROJECTILE_Y_OFFSET = -2

var dir_string
var dir
var spawned_potion
var proj_x = 0
var proj_y = 0

func _frame_6():
	if(data):
		dir_string = xy_to_dir(data.x, data.y)
		dir = Vector2(dir_string.x, dir_string.y)
		proj_x = str(PROJECTILE_SPEED * dir.x)
		proj_y = str((PROJECTILE_SPEED * dir.y) + PROJECTILE_Y_OFFSET)

	var potion = host.pop_potion()
	match(potion):
		host.potions.plague:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true)
		host.potions.boom:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[1], PROJECTILE_X, PROJECTILE_Y, true)
		_:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true)
	spawned_potion.apply_force_relative(proj_x, proj_y)
		
func is_usable():
	return .is_usable() and host.current_potions_number > 0
