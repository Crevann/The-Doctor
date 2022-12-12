extends SuperMove

func is_usable():
	return .is_usable() and host.current_potions_number < host.max_potions
