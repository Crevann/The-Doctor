extends CharacterState

#Refer to the enum inside Doctor.gd
export var _c_Potion = 0
export var potion: int
export(Color) var particle_colors


func _frame_4():
	$"%PotionParticles".get_node("Potion").color = particle_colors
	$"%PotionParticles".start_emitting()
	host.play_sound("PotionCrafted")
	host.push_potion(potion)
