extends Node

const GRAVITY = 1;
const UP = Vector2(0, -1);
const SPEED = 75;
const JUMP_SPEED = 230;
var player_motion = Vector2(0, 0)
var jump_gravity_increment = 0.01;

onready var player = get_node("../../../Bubble_Girl");
onready var sprite = get_node("../../AnimatedSprite");
onready var stateMachine = get_parent();

var current_state;
var apply_gravity = false;
var attack_state;


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = stateMachine.get_state();
	
func _physics_process(delta):
	current_state = stateMachine.get_state();
	attack_state = stateMachine.get_attack_state();
	
	if current_state == self:
		if !attack_state:
			sprite.play("jumping")
		apply_gravity(delta)
		if Input.is_action_pressed("ui_left"):
			player_motion.x = -SPEED;
		elif Input.is_action_pressed("ui_right"):
			player_motion.x = SPEED;
		else: 
			player_motion.x = 0;
		
		if Input.is_action_pressed("jump") && player.is_on_floor():
			player_motion.y = -JUMP_SPEED
			jump_gravity_increment = 10
			apply_gravity = true;
	
		move_character(player_motion)
		
func move_character(motion):
	player.move_and_slide(motion, UP)

func apply_gravity(delta):
	if apply_gravity == true:		
		player_motion.y += 4 + jump_gravity_increment 
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .20
#	print(jump_gravity_increment)
#	if apply_gravity == true:		
#		player_motion.y += 4 + jump_gravity_increment 
#	if !player.is_on_floor():
##		player_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
#		if jump_gravity_increment > 1:
#			jump_gravity_increment -= .35
#	else:
#			player_motion.y = 0;


func _on_HurtEnemy_area_entered(area):
	player_motion.y = -JUMP_SPEED;
	jump_gravity_increment = 10;
	apply_gravity = true;
