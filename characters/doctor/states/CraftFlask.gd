extends CharacterState

#Refer to the enum inside Doctor.gd
export var potion: int

func _frame_4():
	$"%PotionParticles".start_emitting()
	host.play_sound("PotionCrafted")
	host.push_potion(potion)
