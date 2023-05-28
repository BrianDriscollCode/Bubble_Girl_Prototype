extends Area2D


onready var timer = get_node("Timer");
onready var sprite = get_node("AnimatedSprite");
var current_health = 3;

onready var player = get_tree().get_current_scene().get_node("Bubble_Girl");
var x_offset = 0
var y_offset = 0
var min_distance = 30;


func _physics_process(delta):

	if current_health <= 0:
		queue_free();
	if sprite.get_frame() == 4 && sprite.get_animation() == "take_damage":
		sprite.play("default");
		sprite.set_rotation_degrees(0);
		
	var distance = (self.global_position - (player.global_position + Vector2(x_offset, y_offset))).length()

	# Only lerp if the distance is greater than the minimum distance threshold
	if distance > min_distance:
		self.global_position = self.global_position.linear_interpolate(player.global_position + Vector2(x_offset, y_offset), delta * 0.4)
	elif distance <= min_distance:
		if self.global_position.x < player.global_position.x:
			self.global_position.x += 0.2;
		elif self.global_position.x > player.global_position.x:
			self.global_position.x -= 0.2;
		else: 
			pass;
		if self.global_position.y < player.global_position.y:
			self.global_position.y += 0.2;
		elif self.global_position.y > player.global_position.y:
			self.global_position.y -= 0.2;
		else:
			pass;
	
			
		


func _on_skull_area_entered(area):
	pass;
	

#if float(current_health) / float(full_health) < 0.6 && float(current_health) / float(full_health) > 0.30001:
#		self.set_modulate(Color(0.92, 0.82, 0.06, 1));
#	elif  float(current_health) / float(full_health) < 0.3:
#		self.set_modulate(Color(0.92, 0.22, 0.06, 1));
#	else:
#		self.set_modulate(Color(255, 255, 255, 255));
#	print(float(current_health) /  float(full_health))

func _on_Timer_timeout():
	sprite.set_modulate(Color(1,1,1,1));


func _on_TakeDamage_area_entered(area):
	current_health -= 1;
	if current_health == 2:
		sprite.set_modulate(Color(0.92, 0.82, 0.06, 1));
	else:
		sprite.set_modulate(Color(0.92, 0.22, 0.06, 1));
	timer.start();
	sprite.play("take_damage");
	sprite.set_rotation_degrees(40);
