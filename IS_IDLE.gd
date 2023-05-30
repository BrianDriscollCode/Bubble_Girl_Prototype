extends Node

const GRAVITY = 10;
const UP = Vector2(0, -1);
const SPEED = 70;
var player_motion = Vector2(0, 0)
var jump_gravity_increment = 1;

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
	
func _physics_process(delta):
	current_state = stateMachine.get_state();
	attack_state = stateMachine.get_attack_state();
	
	if current_state == self:
		sprite.set_speed_scale(1);
		if !attack_state:
			sprite.play("idle");
		apply_gravity(delta)
		player_motion.x = 0;
		move_character(player_motion)
func move_character(motion):
	player.move_and_slide(motion, UP)

func apply_gravity(delta):
	if apply_gravity == true:		
		player_motion.y += 4 + jump_gravity_increment 
	if !player.is_on_floor():
		player_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
	else:
			player_motion.y = 0;
