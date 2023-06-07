extends Node

onready var IS_JUMPING = get_node("IS_JUMPING");
onready var IS_IDLE = get_node("IS_IDLE");
onready var IS_RUNNING = get_node("IS_RUNNING");
onready var IS_DAMAGED = get_node("IS_DAMAGED");

onready var attacking = false;

var temp_invincibility = false;
onready var invincible_timer = get_node("../InvincibleTimer");

var direction;
var current_state;
var prev_state;
var state_text;
onready var player = get_parent();
onready var text = get_node("../RichTextLabel");

var counter = 0;

var ledgeNodes;
		
func _ready():
	current_state = IS_IDLE;
	prev_state = IS_RUNNING
	state_text = "IS_IDLE"
	direction = "right";
	
func _physics_process(delta):
	accept_input();
	text.set_text(state_text);
	counter += 1;
	
func accept_input():
	if Input.is_action_pressed("jump") && !temp_invincibility:
		set_state(IS_JUMPING, current_state, "IS_JUMPING");
	elif Input.is_action_pressed("ui_right") && player.is_on_floor() && !temp_invincibility:
		set_state(IS_RUNNING, current_state, "IS_RUNNING");
		direction = "right";
	elif Input.is_action_pressed("ui_left") && player.is_on_floor() && !temp_invincibility:
		set_state(IS_RUNNING, current_state, "IS_RUNNING");
		direction = "left";
	elif player.is_on_floor() && !temp_invincibility:
		set_state(IS_IDLE, current_state, "IS_IDLE");
		
	if Input.is_action_just_pressed("attack"):
		attacking = true;
		
	
func set_state(new_state, prev_state, current_state_text):
	# Cannot switch to walking while in the air
	current_state = new_state;
	prev_state = prev_state;
	state_text = current_state_text;
	
	if new_state == IS_IDLE:
		IS_RUNNING.reset_speed();

func get_state():
	return current_state;
	
func get_attack_state():
	return attacking;

func reset_attack_state():
	attacking = false;

func get_direction():
	return direction;

func set_idle():
	set_state(IS_IDLE, current_state, "IS_IDLE");	
	
func set_prev_state():
	set_state(prev_state, current_state, "IDK")
	
func set_damage():
	set_state(IS_DAMAGED, current_state, "IDK")
	temp_invincibility = true;
	invincible_timer.start();
	
func _on_InvincibleTimer_timeout():
	temp_invincibility = false;
