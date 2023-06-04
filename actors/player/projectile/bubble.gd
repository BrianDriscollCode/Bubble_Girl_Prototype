extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level = get_tree().get_current_scene().get_children()[0];
var player_state_machine;

onready var sprite = get_node("AnimatedSprite");
onready var timer = get_node("Timer");
onready var collision_shape = get_node("CollisionShape2D");
var velocity = Vector2(20, 0);
var direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	print(level)
	player_state_machine = level.get_node("Bubble_Girl/StateMachine")
	timer.start();
	direction = player_state_machine.get_direction();
	sprite.play("grow");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == "right":
		self.global_position += velocity * delta;
	else: 
		self.global_position -= velocity * delta;
	if sprite.get_animation() == "explode" && sprite.get_frame() == 7:
		queue_free();
	
	if sprite.get_animation() == "grow" && sprite.get_frame() == 2:
		collision_shape.set_disabled(false);
		sprite.play("default")

func _on_Timer_timeout():
	collision_shape.set_disabled(true);
	sprite.play("explode");
	
func _on_bubble_area_entered(area):
	collision_shape.set_disabled(true);
	sprite.play("explode");
