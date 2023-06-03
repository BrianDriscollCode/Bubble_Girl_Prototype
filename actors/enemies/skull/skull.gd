extends Area2D

enum states {INACTIVE, ACTIVE}
var enemyState = states.INACTIVE;

onready var timer = get_node("Timer");
onready var sprite = get_node("AnimatedSprite");
onready var bubble = get_node("Bubble");
var current_health = 2;

onready var player = get_parent().get_node("Bubble_Girl");
var x_offset = 0
var y_offset = 0
var min_distance = 05;
var speed = 15;
var hurt = false;

onready var raycast_up = get_node("RayCastUp");
onready var raycast_down = get_node("RayCastDown");

func _physics_process(delta):
		
	if enemyState == states.ACTIVE:	
		follow_player(delta);
		set_flip_boolean();
		increase_speed();
		spread_from_other_skulls();
		manage_damage();
	else:
		sprite.play("take_damage");
		sprite.set_frame(0);
	

#LERP CODE
#	var distance = (self.global_position - (player.global_position + Vector2(x_offset, y_offset))).length()
#
#	# Only lerp if the distance is greater than the minimum distance threshold
#	if distance > min_distance && hurt == false && !raycast_down.is_colliding() && !raycast_up.is_colliding():
#		self.global_position = self.global_position.linear_interpolate(player.global_position + Vector2(x_offset, y_offset), delta * 1)

func follow_player(delta):
	if player:
		var direction = (player.global_position - self.global_position).normalized()
	# Move the enemy towards the player
		var velocity = direction * speed * delta
	
		if !hurt:
			translate(velocity)

func manage_damage():
	if current_health <= 0:
		queue_free();
	if sprite.get_frame() == 4 && sprite.get_animation() == "take_damage":
		sprite.play("default");
		sprite.set_rotation_degrees(0);
		hurt = false;
		bubble.set_visible(false);
		speed = 15;

func spread_from_other_skulls():
	if raycast_up.is_colliding():
		self.global_position.y += 0.5;
	elif raycast_down.is_colliding():
		self.global_position.y -= 0.5;

func increase_speed():
	if speed < 30:
		speed += 0.05

func set_flip_boolean():
	if player:
		if player.global_position.x > self.global_position.x:
			sprite.set_flip_h(true);
		else:
			sprite.set_flip_h(false);

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
	hurt = true;

func _on_BubbleCollision_body_entered(body):
	sprite.play("take_damage");
	sprite.set_rotation_degrees(40);
	hurt = true;
	bubble.set_visible(true);
	timer.start();


func _on_SensePlayer_area_entered(area):
	if enemyState == states.INACTIVE:
		sprite.play("default")
	enemyState = states.ACTIVE;


func _on_BubbleCollision_area_entered(area):
	sprite.play("take_damage");
	sprite.set_rotation_degrees(40);
	hurt = true;
	bubble.set_visible(true);
	timer.start();
