extends CharacterBody2D

@export var speed: float = 100
@export var accel: float = 10

@onready var interact_label = $"Interaction Components/InteractLabel"
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()

	if(Input.is_action_just_pressed("interact")):
		PuzzleManager.execute_interactions()
		


func _process(delta):
	if velocity.x == 0 && velocity.y == 0:
		animation.stop()
	elif abs(velocity.x) >= abs(velocity.y):
		if velocity.x < 0:
			animation.play("left")
		elif velocity.x > 0:
			animation.play("right")
	else:
		if velocity.y < 0:
			animation.play("up")
		elif velocity.y > 0:
			animation.play("down")

# Interaction area
func _on_interaction_area_area_entered(area: Area2D):
	interact_label.text = PuzzleManager.on_player_enter_area(area)


func _on_interaction_area_area_exited(area: Area2D):
	interact_label.text = PuzzleManager.on_player_exit_area(area)
