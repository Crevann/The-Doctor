extends DefaultFireball

const DAMAGE_DISTANCE = 64
const y_offset_from_ground = -64

var is_fizzling = false
var is_opponent_inside_this_cloud = false

func _frame_0():
	host.creator.active_clouds.append(self)
	host.sprite.rotation = 0
	#Set grounded or air sprite
	if host.get_pos().y > y_offset_from_ground:
		host.set_pos(host.get_pos().x, y_offset_from_ground)
		$"%Sprite".animation = "cloud_ground"
	else:
		$"%Sprite".animation = "cloud"
		
func _tick():
	._tick()
	#Get opponent distance
	var opponent_position = host.creator.opponent.get_hurtbox_center()
	var opponent_position_vector = Vector2(opponent_position.x, opponent_position.y)
	var cloud_position = host.get_hurtbox_center()
	var cloud_position_vector = Vector2(cloud_position.x, cloud_position.y)
	var distance = cloud_position_vector.distance_to(opponent_position_vector)
	
	#Set if opponent is inside cloud
	if distance < DAMAGE_DISTANCE and !is_fizzling:
		print("Distance: " + str(distance))
		is_opponent_inside_this_cloud = true
	else:
		is_opponent_inside_this_cloud = false
	
func fizzle():
	.fizzle()
	is_fizzling = true
	is_opponent_inside_this_cloud = false
	host.creator.active_clouds.erase(self)
