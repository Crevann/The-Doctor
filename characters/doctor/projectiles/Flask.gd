extends "res://projectile/DirProjectileDefault.gd"

export(String) var to_state
const GLASS_PARTICLE_EFFECT = preload("res://doctor/characters/doctor/particles/GlassShards.tscn")

var direction = Vector2(0, 0)
var old_position
var position = Vector2(0, 0)

func fizzle():
	host.change_state(to_state)
	$"../../Sounds/FlaskBreak".pitch_scale = rand_range(0.9, 1.1)
	host.play_sound("FlaskBreak")
	host.spawn_particle_effect_relative(GLASS_PARTICLE_EFFECT, Vector2(), Vector2(-direction.y, direction.x))
	#$"%Sprite".hide()

func _tick():
	._tick()
	host.sprite.rotation = 0
	old_position = position
	position = Vector2(host.get_pos().x, host.get_pos().y)
	direction = old_position.direction_to(position).normalized()
	
