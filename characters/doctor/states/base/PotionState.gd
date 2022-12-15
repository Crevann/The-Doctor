extends CharacterState

const POTIONS_PROJECTILES = [preload("res://doctor/characters/doctor/projectiles/plague_potion/PlaguePotion.tscn"),
							preload("res://doctor/characters/doctor/projectiles/boom_potion/BoomPotion.tscn")]

const PROJECTILE_X = 0
const PROJECTILE_Y = -16	
			
func is_usable():
	return .is_usable() and host.current_potions_number > 0

func throw(potion, proj_x, proj_y):
	var spawned_potion
	match(potion):
		host.potions.plague:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true)
		host.potions.boom:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[1], PROJECTILE_X, PROJECTILE_Y, true)
		_:
			spawned_potion = host.spawn_object(POTIONS_PROJECTILES[0], PROJECTILE_X, PROJECTILE_Y, true)
	spawned_potion.apply_force(proj_x, proj_y)
	return spawned_potion
