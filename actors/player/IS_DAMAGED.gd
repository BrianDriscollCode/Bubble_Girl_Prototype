extends Node


const GRAVITY = 1;
const UP = Vector2(0, -1);
var current_speed = 70;
const JUMP_SPEED = 230;
var player_motion = Vector2(0, 0)
var jump_gravity_increment = 0.01;

onready var player = get_node("../../../Bubble_Girl");
onready var sprite = get_node("../../AnimatedSprite");
onready var state_machine = get_parent();
onready var IS_RUNNING_STATE = get_node("../IS_RUNNING");
onready var invincible_timer = get_node("../../InvincibleTimer");
onready var take_damage_area_left = get_node("../../TakeDamageLeft");
onready var take_damage_area_right = get_node("../../TakeDamageRight")

var current_state;

func _process(delta):
	current_state = state_machine.get_state();
	
	if current_state == self:
		move_character(player_motion)
		
func move_character(motion):
	player.move_and_slide(motion, UP)


func _on_InvincibleTimer_timeout():
	sprite.set_modulate(Color(1,1,1,1))
	if current_state == self:
		state_machine.set_prev_state()

func _on_TakeDamageLeft_area_entered(area):
	sprite.set_modulate(Color(1,1,1,0.3))

func _on_TakeDamageRight_area_entered(area):
	sprite.set_modulate(Color(1,1,1,0.3))
