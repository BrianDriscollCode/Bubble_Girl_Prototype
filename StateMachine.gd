extends Node

onready var IS_JUMPING = get_node("IS_JUMPING");
onready var IS_IDLE = get_node("IS_IDLE");
onready var IS_RUNNING = get_node("IS_RUNNING");

var direction;
var current_state;
var prev_state;
var state_text;
onready var player = get_parent();
onready var text = get_node("../RichTextLabel");


var ledgeNodes;
		
func _ready():
	current_state = IS_IDLE;
	prev_state = IS_RUNNING
	state_text = "IS_IDLE"
	direction = "right";
	
func _physics_process(delta):
	print(player.is_on_floor())
	accept_input();
	text.set_text(state_text);
	
func accept_input():
	if Input.is_action_pressed("jump"):
		set_state(IS_JUMPING, current_state, "IS_JUMPING");
	elif Input.is_action_pressed("ui_right") && player.is_on_floor():
		set_state(IS_RUNNING, current_state, "IS_RUNNING");
		direction = "right";
	elif Input.is_action_pressed("ui_left") && player.is_on_floor():
		set_state(IS_RUNNING, current_state, "IS_RUNNING");
		direction = "left";
	elif player.is_on_floor():
		set_state(IS_IDLE, current_state, "IS_IDLE");
		
	
func set_state(new_state, prev_state, current_state_text):
	# Cannot switch to walking while in the air
	current_state = new_state;
	prev_state = prev_state;
	state_text = current_state_text;

func get_state():
	return current_state;

func get_direction():
	return direction;

func set_idle():
	set_state(IS_IDLE, current_state, "IS_IDLE");


