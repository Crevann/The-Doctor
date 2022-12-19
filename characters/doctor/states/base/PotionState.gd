extends CharacterState

const POTIONS_PROJECTILES = [preload("res://doctor/characters/doctor/projectiles/plague_potion/PlaguePotion.tscn"),
							preload("res://doctor/characters/doctor/projectiles/boom_potion/BoomPotion.tscn"),
							preload("res://doctor/characters/doctor/projectiles/wind_potion/WindPotion.tscn")]

const PROJECTILE_X = 0
const PROJECTILE_Y = -16	
var spawned_potion
			
func is_usable():
	return .is_usable() and host.current_potions_number > 0

func throw(potion, proj_x, proj_y):
	match(potion):
		host.potions.plague:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y)
		host.potions.boom:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[1], PROJECTILE_X, PROJECTILE_Y)
		host.potions.wind:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[2], PROJECTILE_X, PROJECTILE_Y)
		_:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y)
	spawned_potion.apply_force(proj_x, proj_y)
	return spawned_potion
