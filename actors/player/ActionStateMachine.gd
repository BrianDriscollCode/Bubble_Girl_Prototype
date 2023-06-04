extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parent = get_node("../../Bubble_Girl");
var player_position;
onready var bubble = preload("res://actors/player/projectile/bubble.tscn")
onready var scene = get_tree().get_current_scene();
onready var sprite = get_node("../AnimatedSprite");

onready var state_machine = get_node("../StateMachine");
var x_offset;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		sprite.play("attack")
		var newBubble = bubble.instance();
		if state_machine.get_direction() == "right":
			player_position = parent.get_global_position() + Vector2(10, 0);
		else:
			player_position = parent.get_global_position() + Vector2(-10, 0);
		newBubble.set_global_position(player_position);
		scene.add_child(newBubble)
	
	if sprite.get_animation() == "attack" && sprite.get_frame() == 2:
		state_machine.reset_attack_state();
		
		
