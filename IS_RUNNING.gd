extends Node

const GRAVITY = 70;
const UP = Vector2(0, -1);
var current_speed = 70;
const MAX_SPEED = 100;
const SPEED_INCREMENT = 0.25;
var character_motion = Vector2(0, 0)
var jump_gravity_increment = 1;

var anim_speed;
const MIN_ANIM_SPEED = 0.8;
const MAX_ANIM_SPEED = 2;

onready var player = get_node("../../../Bubble_Girl");
onready var sprite = get_node("../../AnimatedSprite");
onready var stateMachine = get_parent();

var current_state;
var apply_gravity;
var attack_state;


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = stateMachine.get_state();
	apply_gravity = true;
	anim_speed = MIN_ANIM_SPEED;
	
func _physics_process(delta):
	current_state = stateMachine.get_state();
	attack_state = stateMachine.get_attack_state();
	
	if current_state == self:
		if !attack_state:
			sprite.play("running")
			sprite.set_speed_scale(anim_speed);
		if current_speed < MAX_SPEED:
			current_speed += SPEED_INCREMENT;
			if current_speed == MAX_SPEED:
				anim_speed == MAX_ANIM_SPEED;
			elif anim_speed < MAX_ANIM_SPEED:
				anim_speed += 0.025
			else:
				pass;
		apply_gravity(delta)
		if Input.is_action_pressed("ui_left"):
			character_motion.x = -current_speed;
			sprite.set_flip_h(true);
		elif Input.is_action_pressed("ui_right"):
			character_motion.x = current_speed;
			sprite.set_flip_h(false);
		else:
			character_motion.x = 0;
		move_character(character_motion)
func move_character(motion):
	player.move_and_slide(motion, UP)

			
func apply_gravity(delta):
	if apply_gravity == true:		
		character_motion.y += 4 + jump_gravity_increment 
	if !player.is_on_floor():
		character_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
	else:
			character_motion.y = 0;
			
func reset_speed():
	current_speed = 70;
	anim_speed = MIN_ANIM_SPEED;
	
	

func get_speed():
	return current_speed;

	
		
