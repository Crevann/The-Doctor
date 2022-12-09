extends PlayerInfo

enum potions{
	plague,
	boom,
	freeze,
	acid,
	last
}

onready var flasks = [$"%Flask1", $"%Flask2", $"%Flask3"]

func set_fighter(fighter):
	.set_fighter(fighter)
	fighter.connect("update_potion", self, "_on_update_flasks")
	if player_id == 2:
		$HBoxContainer.alignment = BoxContainer.ALIGN_END

func _on_update_flasks():
	for p in fighter.max_potions:
		if p < fighter.prepared_potions.size():
			match (fighter.prepared_potions[p]):
				fighter.potions.plague:
					flasks[p].frame = 1
				fighter.potions.boom:
					flasks[p].frame = 2
				fighter.potions.freeze:
					flasks[p].frame = 3
				fighter.potions.acid:
					flasks[p].frame = 4
		else:
			flasks[p].frame = 0
