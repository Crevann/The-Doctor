extends CharacterState

export var _c_Sparks = 0
export(PackedScene) onready var SparkScene
export(Vector2) var offset

func _frame_2():
	host.spawn_particle_effect_relative(SparkScene, offset, Vector2(host.get_facing_int(), 0))
