extends KinematicBody2D

onready var fire = get_node("Fire");

const UP = Vector2(0, -1);
const JUMP_SPEED = 120;
const GRAVITY = 500;
var jump_gravity_increment = 3;
var motion = Vector2(0,0);
var apply_gravity = false;

var activated = false;

func _ready():
	apply_gravity = true;
	fire.set_visible(false);

func _physics_process(delta):
	if activated == false:
		motion.y = -JUMP_SPEED;
		activated = true;
	move_character(motion);
	apply_gravity(delta);
	
	if is_on_floor():
		fire.set_visible(true);
		motion.y = 0;
		motion.x = 0;

func move_character(motion):
	self.move_and_slide(motion, UP)

func apply_gravity(delta):
	if apply_gravity == true:		
		motion.y += 2 + jump_gravity_increment 
		if jump_gravity_increment > 1:
			jump_gravity_increment -= .20

func set_direction(direction):
	if direction == "left":
		motion.x = 40;
	else:
		motion.x = -40;

