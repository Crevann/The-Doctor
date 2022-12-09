extends CharacterState

#Refer to the enum inside Doctor.gd
export var potion: int

func _frame_10():
	host.push_potion(potion)
