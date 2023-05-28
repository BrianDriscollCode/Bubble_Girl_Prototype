extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 1;
onready var sprite = get_node("AnimatedSprite");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TakeDamage_area_entered(area):
	health -= 1;
	if health < 1:
		sprite.set_modulate(Color(0.92, 0.82, 0.06, 1));
	print(area);
