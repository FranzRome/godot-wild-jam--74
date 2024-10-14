extends CharacterBody2D

@export var speed: float = 100
@export var accel: float = 10

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
