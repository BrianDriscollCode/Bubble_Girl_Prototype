extends Node

const GRAVITY = 10;
const UP = Vector2(0, -1);
const SPEED = 70;
var character_motion = Vector2(0, 0)

onready var character = get_node("../../../Bubble_Girl");
onready var sprite = get_node("../../AnimatedSprite");
onready var stateMachine = get_parent();

var current_state;


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = stateMachine.get_state();
	
func _physics_process(delta):
	current_state = stateMachine.get_state();
	
	if current_state == self:
		sprite.play("idle")
		apply_gravity()
		character_motion.x = 0;
		move_character(character_motion)
func move_character(motion):
	character.move_and_slide(motion, UP)

func apply_gravity():
	character_motion.y = GRAVITY;
