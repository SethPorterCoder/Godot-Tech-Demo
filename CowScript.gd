extends CharacterBody2D
var rng = RandomNumberGenerator.new();
@onready var idle = $idle
@onready var walk = $walk
@onready var id = "cow"

func _ready():
	idle.start(rng.randf_range(0, 5))

func _on_idle_timeout():
	velocity.x = round(rng.randf_range(-1, 1));
	velocity.y = round(rng.randf_range(-1, 1));
	velocity = velocity * 10
	idle.stop()
	walk.start(rng.randf_range(0, 5))
	
func _on_timer_timeout():
	velocity.x = 0;
	velocity.y = 0;
	idle.start(rng.randf_range(0, 5))
	walk.stop()

func _process(delta):
	#move_and_slide() This messes up top down collision
	move_and_collide(velocity * delta)
