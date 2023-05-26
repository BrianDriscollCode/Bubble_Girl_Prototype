extends Node

const GRAVITY = 70;
const UP = Vector2(0, -1);
const SPEED = 70;
var character_motion = Vector2(0, 0)
var jump_gravity_increment = 1;

onready var player = get_node("../../../Bubble_Girl");
onready var sprite = get_node("../../AnimatedSprite");
onready var stateMachine = get_parent();

var current_state;


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = stateMachine.get_state();
	
func _physics_process(delta):
	current_state = stateMachine.get_state();
	
	if current_state == self:
		sprite.play("running")
		apply_gravity(delta)
		if Input.is_action_pressed("ui_left"):
			character_motion.x = -SPEED;
			sprite.set_flip_h(true);
		elif Input.is_action_pressed("ui_right"):
			character_motion.x = SPEED;
			sprite.set_flip_h(false);
		else:
			character_motion.x = 0;
		move_character(character_motion)
func move_character(motion):
	player.move_and_slide(motion, UP)

			
func apply_gravity(delta):
#	if apply_gravity == true:		
#		character_motion.y += 4 + jump_gravity_increment 
	if !player.is_on_floor():
		character_motion.y += (jump_gravity_increment * 2) + jump_gravity_increment * delta
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .15
	else:
			character_motion.y = 0;

	
		
