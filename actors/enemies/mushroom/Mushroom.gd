extends KinematicBody2D


enum states {
	IDLE,
	FOLLOW,
	SPRAY
}

var current_state;
const JUMP_SPEED = 120;
const UP = Vector2(0, -1);
var enemy_motion = Vector2(0, 0);
onready var jump_timer = get_node("JumpTimer");
onready var follow_timer = get_node("FollowTimer");
onready var spray_timer = get_node("SprayTimer");
onready var player = get_parent().get_node("Bubble_Girl");
onready var sprite = get_node("AnimatedSprite");
onready var text = get_node("RichTextLabel");
onready var spray_damage_area = get_node("SprayDamage/CollisionPolygon2D");
onready var stand_on_collision = get_node("StandOnCollision");

#particles
onready var particle1 = get_node("ramp");
onready var particle2 = get_node("ramp2");
onready var particle3 = get_node("ramp3");
onready var particle4 = get_node("ramp4");
onready var particle5 = get_node("ramp5");
onready var particle6 = get_node("ramp6");
onready var particle7 = get_node("ramp7");
onready var particle8 = get_node("ramp8");

var particles;

var can_jump = true;
var apply_gravity = false;
var jump_gravity_increment = 10;


func _ready():
	print(player);
	current_state = states.IDLE;
	text.set_text("IDLE")
	particles = [particle1, particle2, particle3, particle4, particle5, particle6, particle7, particle8]
	
	for particle in particles:
		particle.set_emitting(false);
		particle.set_amount(20);
	spray_timer.start();
	sprite.play("idle")

func _physics_process(delta):
	apply_gravity(delta);
	
	if self.is_on_floor() && current_state != states.SPRAY:
		apply_gravity = false;
		enemy_motion.y = 0;
		enemy_motion.x = 0;
		sprite.play("idle")
		
	if current_state == states.IDLE:
		pass;
#		if self.is_on_floor():
#			sprite.play("idle");
	
	if current_state == states.FOLLOW:
		jump();
#		if self.is_on_floor():
#			sprite.play("idle");
	
	if current_state == states.SPRAY:
		sprite.play("attack");
	
	move_and_slide(enemy_motion, UP)
	
	if sprite.get_animation() == "idle":
		if sprite.get_frame() == 0:
			stand_on_collision.position = Vector2(0, 6);
		elif sprite.get_frame() == 1:
			stand_on_collision.position = Vector2(0, 8);
		elif sprite.get_frame() == 2:
			stand_on_collision.position = Vector2(0, 3);
		elif sprite.get_frame() == 3:
			stand_on_collision.position = Vector2(0, 4);
			

func jump():
	if can_jump:
		print("JUMP")
		sprite.play("jump")
		can_jump = false;
		enemy_motion.y -= JUMP_SPEED;
		apply_gravity = true;
		if player.get_global_position().x > self.get_global_position().x:
			enemy_motion.x += 30;
		elif player.get_global_position().x < self.get_global_position().x:
			enemy_motion.x -= 30;
		else:
			pass
		
		jump_timer.start();
		

func apply_gravity(delta):
	if apply_gravity == true:		
		enemy_motion.y += 4 + jump_gravity_increment 
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .20

func _on_SensePlayer_area_entered(area):
	current_state = states.FOLLOW;
	text.set_text("FOLLOW")
	
func _on_JumpTimer_timeout():
	can_jump = true;

func _on_SprayTimer_timeout():
	current_state = states.SPRAY;
	spray_damage_area.set_disabled(false);
	text.set_text("SPRAY")
	jump_timer.stop();
	for particle in particles:
		particle.set_emitting(true);
	follow_timer.start();

func _on_FollowTimer_timeout():
	sprite.play("idle")
	spray_damage_area.set_disabled(true);
	current_state = states.FOLLOW;
	text.set_text("FOLLOW")
	jump_timer.start();
	for particle in particles:
		particle.set_emitting(false);
	spray_timer.start();
