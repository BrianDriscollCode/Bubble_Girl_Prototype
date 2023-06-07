extends Camera2D

onready var player = get_node("../Bubble_Girl")
onready var player_state_node = get_node("../Bubble_Girl/StateMachine")
var y_offset = -30
var x_offset = 0
var player_direction
var min_distance = 0.5

func _physics_process(delta):
	player_direction = receive_player_direction()
	if player_direction == "right":
		x_offset = 1
	elif player_direction == "left":
		x_offset = -1
	else:
		x_offset = 0

	# Calculate the distance between the camera and the target position
	var distance = (self.global_position - (player.global_position + Vector2(x_offset, y_offset))).length()

	# Only lerp if the distance is greater than the minimum distance threshold
	if distance > min_distance:
		self.global_position = self.global_position.linear_interpolate(player.global_position + Vector2(x_offset, y_offset), delta * 10.0)

	# If the distance is below the threshold, snap to the player position
	elif distance <= min_distance:
		self.global_position = player.global_position + Vector2(x_offset, y_offset)

func receive_player_direction():
	return player_state_node.get_direction();
