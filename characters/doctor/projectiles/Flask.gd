extends "res://projectile/DirProjectileDefault.gd"

export(String) var to_state
const GLASS_PARTICLE_EFFECT = preload("res://doctor/characters/doctor/particles/GlassShards.tscn")

func fizzle():
	host.change_state(to_state)
	$"../../Sounds/FlaskBreak".pitch_scale = rand_range(0.9, 1.1)
	host.play_sound("FlaskBreak")
	host.spawn_particle_effect_relative(GLASS_PARTICLE_EFFECT, Vector2())
	#$"%Sprite".hide()

func _tick():
	._tick()
	host.sprite.rotation = 0
	
