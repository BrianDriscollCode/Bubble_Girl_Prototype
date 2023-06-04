extends KinematicBody2D

var health = 1;
onready var sprite = $AnimatedSprite
onready var state_machine = $StateMachine;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TakeDamageRight_area_entered(area):
	print("right collision")
	health -= 1;
	if health < 1:
		sprite.set_modulate(Color(0.92, 0.82, 0.06, 1));
	state_machine.set_damage();
	

func _on_TakeDamageLeft_area_entered(area):
	print("left collision")
	health -= 1;
	if health < 1:
		sprite.set_modulate(Color(0.92, 0.82, 0.06, 1));
	state_machine.set_damage();
	print("Run left")
