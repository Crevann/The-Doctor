extends "res://doctor/characters/doctor/states/base/PotionSuperState.gd"

#Barrage data
const PROJECTILE_SPEED_MIN_X = 2
const PROJECTILE_SPEED_MIN_Y = -10
const PROJECTILE_SPEED_MAX_X = 6
const PROJECTILE_SPEED_MAX_Y = -5
const POTION_FREQUENCY = 2

#Cluster data
const POTION_CLUSTER_SIZE = 10
const POTION_CLUSTER_X_SPEED = 0
const POTION_CLUSTER_Y_SPEED = -20
const POTION_CLUSTER_SPREAD_VARIATION = 6
const POTION_CLUSTER_LIFETIME = 999999

var dir_string
var dir
var proj_x = 0
var proj_y = 0
var current_potion_to_spawn = 0 #to get rythmic potion spawn pattern
var rng = RandomNumberGenerator.new()

func _tick():
	._tick()
	rng.seed = current_tick
	if current_tick % POTION_FREQUENCY == 0 and current_tick <= 14:
		proj_x = str(rng.randf_range(PROJECTILE_SPEED_MIN_X, PROJECTILE_SPEED_MAX_X) * host.get_facing_int())
		proj_y = str(rng.randf_range(PROJECTILE_SPEED_MIN_Y, PROJECTILE_SPEED_MAX_Y))
		var potion = current_potion_to_spawn%2
		throw(potion, proj_x, proj_y)
	
func _frame_42():
	for i in POTION_CLUSTER_SIZE:
		var potion = current_potion_to_spawn%2
		proj_x = str((POTION_CLUSTER_X_SPEED + rng.randf_range(-POTION_CLUSTER_SPREAD_VARIATION, POTION_CLUSTER_SPREAD_VARIATION)) * host.get_facing_int())
		proj_y = str(POTION_CLUSTER_Y_SPEED + rng.randf_range(0, POTION_CLUSTER_SPREAD_VARIATION))
		throw(potion, proj_x, proj_y)
		spawned_potion.get_node("StateMachine/Default").lifetime = POTION_CLUSTER_LIFETIME

func throw(potion, proj_x, proj_y):
	current_potion_to_spawn += 1
	print(current_potion_to_spawn%3)
	.throw(potion, proj_x, proj_y)
	
