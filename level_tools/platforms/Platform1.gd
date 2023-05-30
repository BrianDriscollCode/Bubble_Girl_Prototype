extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var path = get_node("Path2D/PathFollow2D");

var current_offset;
var go_right = true;
var go_left = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_current_offset();
	
	if go_right:
		move_right(delta);
	elif go_left: 
		move_left(delta);
	else:
		pass;

func move_right(delta):
	if current_offset < 1:
		path.set_offset(path.get_offset() + 15 * delta);
	
func move_left(delta):
	if current_offset > 0:
		path.set_offset(path.get_offset() - 15 * delta);

func get_current_offset():
	current_offset = path.get_unit_offset();
	if current_offset > .995:
		go_right = false;
		go_left = true;
	elif current_offset < 0.002:
		go_right = true;
		go_left = false;
