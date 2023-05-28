extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = get_node("AnimatedSprite");
onready var timer = get_node("Timer");
onready var collision_shape = get_node("CollisionShape2D");
var velocity = Vector2(20, 0);

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position += velocity * delta;
	
	if sprite.get_animation() == "explode" && sprite.get_frame() == 7:
		queue_free();

func _on_Timer_timeout():
	sprite.play("explode");
	collision_shape.set_disabled(true);
