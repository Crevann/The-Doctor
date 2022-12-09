extends CharacterState

const POTIONS_PROJECTILES = [preload("res://doctor/characters/doctor/projectiles/plague_potion/PlaguePotion.tscn"),
							preload("res://doctor/characters/doctor/projectiles/boom_potion/BoomPotion.tscn")]

const PROJECTILE_X = 0
const PROJECTILE_Y = -16
const PROJECTILE_SPEED = 10

var dir
var spawned_potion

func _frame_6():
	if(data):
		dir = xy_to_dir(data.x, data.y)

	var potion = host.pop_potion()
	match(potion):
		host.potions.plague:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true, {"dir":dir})
			spawned_potion.apply_force_relative(0, 5)
		host.potions.boom:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[1], PROJECTILE_X, PROJECTILE_Y, true, {"dir":dir})
			spawned_potion.apply_force_relative(0, 5)
		_:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true, {"dir":dir})
			spawned_potion.apply_force_relative(0, 5)

func is_usable():
	return .is_usable() and host.current_potions_number > 0
