extends Area2D


onready var particle_smoke = $smoke;
onready var sprite = $AnimatedSprite;

onready var collision1 = $CollisionShape2D;
onready var collision2 = $TakeDamage;

enum states {
	IS_IDLE,
	IS_FOLLOWING
}

func _on_TakeDamage_area_entered(area):
	collision1.queue_free();
	collision2.queue_free();
	sprite.play("death");
	particle_smoke.queue_free();
