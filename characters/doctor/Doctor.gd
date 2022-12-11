extends Fighter

enum potions{
	plague,
	boom,
	freeze,
	acid,
	last
}
signal update_potion()

onready var PLAGUE_TICK_PARTICLES = preload("res://doctor/characters/doctor/particles/PlagueTickParticles.tscn")
onready var CURED_PARTICLES = preload("res://doctor/characters/doctor/particles/CuredParticles.tscn")

const CLOUD_TICK_DAMAGE = 5
const PLAGUE_TICK_DAMAGE = 20
const max_potions = 3
const PLAGUE_TICKS = 5
const TICK_FREQUENCY = 5
const PLAGUE_TICK_FREQUENCY = 60

const MIN_OPPONENT_HP = 5

var opponent_is_inside_cloud
var opponent_is_plagued = false
var current_potions_number
var remaining_plague_ticks = -1

var prepared_potions = []
var active_clouds = []

func init(pos = null):
	.init(pos)
	current_potions_number = 0

func tick():
	.tick()
	opponent_is_inside_cloud = check_inside_clouds(active_clouds)
	#Opponent is cured particle
	if remaining_plague_ticks == 0:
		remaining_plague_ticks -= 1
		opponent.spawn_particle_effect_relative(CURED_PARTICLES, Vector2(0, -16))
		play_sound("Cure")
	
	#Deal cloud damage
	if opponent_is_inside_cloud and opponent.hp > MIN_OPPONENT_HP and current_tick % TICK_FREQUENCY == TICK_FREQUENCY - 1:
		opponent.hp -= CLOUD_TICK_DAMAGE
		remaining_plague_ticks = PLAGUE_TICKS
		
	#Opponent is plagued
	if remaining_plague_ticks > 0 and opponent.hp > MIN_OPPONENT_HP and current_tick % PLAGUE_TICK_FREQUENCY == PLAGUE_TICK_FREQUENCY - 1:
		remaining_plague_ticks -= 1
		deal_tick_damage(PLAGUE_TICK_DAMAGE, PLAGUE_TICK_PARTICLES)
		
func check_inside_clouds(clouds):
	if clouds.empty():
		return false
		
	for c in clouds:
		var c_ref = weakref(c)
		if c_ref.get_ref() and c.is_opponent_inside_this_cloud:
			return true
	return false

func push_potion(potion):
	if(current_potions_number < max_potions):
		current_potions_number += 1
		var pushed_potion = prepared_potions.push_back(potion)
		emit_signal("update_potion")
		return pushed_potion
	else:
		print("Potions full")

func pop_potion():
	if(current_potions_number > 0):
		current_potions_number -= 1
		var popped_potion = prepared_potions.pop_back()
		emit_signal("update_potion")
		return popped_potion
	else:
		print("No potions")
		
func deal_tick_damage(damage, effect):
	opponent.hp -= damage
	opponent.gain_super_meter(damage / DAMAGE_SUPER_GAIN_DIVISOR)
	gain_super_meter(damage / DAMAGE_TAKEN_SUPER_GAIN_DIVISOR)
	opponent.spawn_particle_effect_relative(effect, Vector2(0, -16))
	$Sounds/TickDamage.pitch_scale = rand_range(0.9, 1.1)
	play_sound("TickDamage")
	
