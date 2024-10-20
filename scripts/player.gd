extends CharacterBody2D

@export var speed: float = 100
@export var accel: float = 20

@onready var interact_label = $"Interaction Components/InteractLabel"
@onready var animation_character: AnimatedSprite2D = $AnimatedSprite2D

@onready var animation_weapon : AnimationPlayer = $AnimationPlayer
@onready var weapon : Node2D = $Weapon
# Called when the node enters the scene tree for the first time.
var character_face_direction = "down"
var is_attacking = false

func _physics_process(delta):
	if(is_attacking):
		return
	if(Input.is_action_just_pressed("attack")):
		attack()
		return
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")	
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	
	if(Input.is_action_just_pressed("interact")):
		PuzzleManager.execute_interactions()
		

func attack():
	if(PuzzleManager.is_silver_dagger_chest_open == false):
		return
	animation_weapon.play("attack_" + character_face_direction)
	is_attacking = true
	weapon.visible = true
	await animation_weapon.animation_finished
	weapon.visible = false
	is_attacking = false
	

func _process(delta):
	if velocity.x == 0 && velocity.y == 0:
		animation_character.stop()
	elif abs(velocity.x) >= abs(velocity.y):
		if velocity.x < 0:
			animation_character.play_backwards("left")
			character_face_direction = "left"
		elif velocity.x > 0:
			animation_character.play_backwards("right")
			character_face_direction = "right"
	else:
		if velocity.y < 0:
			animation_character.play_backwards("up")
			character_face_direction = "up"
		elif velocity.y > 0:
			animation_character.play("down")
			character_face_direction = "down"

# Interaction area
func _on_interaction_area_area_entered(area: Area2D):
	interact_label.text = PuzzleManager.on_player_enter_area(area)
	print("area entered")
	print(interact_label.text)


func _on_interaction_area_area_exited(area: Area2D):
	interact_label.text = PuzzleManager.on_player_exit_area(area)
