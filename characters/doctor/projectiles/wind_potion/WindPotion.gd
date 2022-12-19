extends DefaultFireball

onready var wind_particles = preload("res://doctor/characters/doctor/particles/WindPotionExplosion.tscn")
onready var windbox = $"%WindBox"
var host_pos

const PULL_MAX_FORCE = 5
const PULL_MAX_DISTANCE = 128

var wind_pulled = []
var pulled_objs = []

func _tick():
	._tick()
	#Hide sprite and spawn particles
	if current_tick <= 0:
		$"%Sprite".hide()
		host.spawn_particle_effect_relative(wind_particles)
	
	host_pos = host.get_pos()
	
	windbox.update_position(host_pos.x, host_pos.y)
	#Get objects to pull
	for obj in host.objs_map.values():
			if obj is BaseObj and not obj == host and not obj == host.creator and obj.current_state().state_name != "Burst" and windbox.overlaps(obj.hurtbox):
					wind_pulled.append(obj)
	#Pull
	for obj in wind_pulled:
		if pulled_objs.find(obj) == -1:
			pull_object(obj)

func pull_object(obj):
	pulled_objs.append(obj)
	var obj_pos = obj.get_pos_visual()
	var wind_pos = $"%WindBox".get_absolute_position()
	var distance = Vector2(wind_pos.x, wind_pos.y) - obj_pos
	var direction = distance.normalized()
	var pull_strength
	if distance.length() > 0:
		pull_strength = PULL_MAX_FORCE * (distance.length()/PULL_MAX_DISTANCE)
		print(distance.length()/PULL_MAX_DISTANCE)
	else:
		pull_strength = 0
	print(pull_strength)
	var pull = direction * pull_strength
	if obj.is_grounded():
		pull.y = 0
	obj.apply_force(str(pull.x), str(pull.y))
