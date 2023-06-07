extends Area2D

onready var level = get_parent().get_parent();

var alive = true;
onready var directional_fireball;

onready var particle_smoke = $smoke;
onready var sprite = $AnimatedSprite;

onready var collision1 = $CollisionShape2D;
onready var collision2 = $TakeDamage;

onready var moving_state_timer = $returnToMovingState;
onready var start_timer = $startTimer;
onready var fireball_timer = $fireballTimer;

export var originalPosition : Vector2;
export var leftPosition : Vector2;
export var rightPosition : Vector2;
export var left_changer: Vector2 = Vector2(-35, 0);
export var right_changer: Vector2 = Vector2(35, 0);
var speed;
var direction;

var is_on_left = false;
var is_on_right = false;

var flip_status = true;

enum states {
	IS_IDLE,
	IS_MOVING
}

var current_state;
var fireball_summoned = 0;

func _ready():
	print(level)
	originalPosition = self.get_global_position();
	leftPosition = originalPosition + left_changer;
	rightPosition = originalPosition + right_changer;
	direction = "left";
	current_state = states.IS_IDLE;
	var random_time = randi() % 4 + 1;
	print(random_time)
	print("hello")
	start_timer.set_wait_time(random_time);
	start_timer.start();
	
	
func _physics_process(delta):
	
	if current_state == states.IS_IDLE:
		speed = Vector2(0, 0);
		sprite.play("idle")
		if fireball_summoned == 0:
			directional_fireball = load("res://actors/enemies/fire_bobble/projectile/directional_fireball_v2.tscn").instance();
			directional_fireball.set_direction(direction);
			if direction == "left":
				directional_fireball.global_position = self.global_position + Vector2(-2, -10)
			else:
				directional_fireball.global_position = self.global_position + Vector2(-2, -10)
			level.add_child(directional_fireball)
			fireball_summoned += 1;
			fireball_timer.start();
		
	if current_state == states.IS_MOVING:
		sprite.play("walk")
		if direction == "left":
			speed = Vector2(-0.25,0);
		elif direction == "right":
			speed = Vector2(0.25,0);
			
		if self.global_position.x < leftPosition.x && !is_on_left:
			current_state = states.IS_IDLE;
			direction = "right";
			moving_state_timer.start();
			is_on_left = true;
			is_on_right = false;
			print("Flip")
		elif self.global_position.x > rightPosition.x && !is_on_right:
			current_state = states.IS_IDLE;
			direction = "left";
			moving_state_timer.start();
			is_on_right = true;
			is_on_left = false;
			print("Flip")
			
	self.global_position += speed;

func _on_TakeDamage_area_entered(area):
	collision1.queue_free();
	collision2.queue_free();
	sprite.play("death");
	particle_smoke.queue_free();
	set_physics_process(false)
	alive = false;


func _on_returnToMovingState_timeout():
	current_state = states.IS_MOVING;
	sprite.set_flip_h(flip_status);
	flip_status = !flip_status;
	
	if flip_status && alive:
		particle_smoke.position = Vector2(2, -10);
		particle_smoke.set_direction(Vector2(1, 0))
	elif !flip_status && alive:
		particle_smoke.position = Vector2(-2, -10)
		particle_smoke.set_direction(Vector2(-1, 0))

func _on_startTimer_timeout():
	current_state = states.IS_MOVING;
	print("start timer run")


func _on_fireballTimer_timeout():
	fireball_summoned = 0;
