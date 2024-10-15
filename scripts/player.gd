extends CharacterBody2D

@export var speed: float = 100
@export var accel: float = 10
var _last_direction: Vector2 = Vector2.ZERO
@export var _interaction_distance = 1

@onready var all_interactions = []
@onready var interact_label = $"Interaction Components/InteractLabel"

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	_last_direction = direction
	if(Input.is_action_just_pressed("interact") == true):
		execute_interactions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#Area di interazione 

func _on_interaction_area_area_entered(area: Area2D):
	all_interactions.insert(0, area)
	_update_interactions()


func _on_interaction_area_area_exited(area: Area2D):
	all_interactions.erase(area)
	_update_interactions()
	

func _update_interactions():
	print("visual aggiornato")
	if(all_interactions):
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""
	
	
var button_a_pressed = false
var button_b_pressed = false
var button_c_pressed = false

func execute_interactions():
	#chiama funziona interact della leva
	all_interactions[0].interact_leva()
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"toggle button A": 
				button_a_pressed = !button_a_pressed
				print("button a: " +  str(button_a_pressed) )
			"toggle button B":
				button_b_pressed = !button_b_pressed
				print("button b: " + str(button_b_pressed))
			"toggle button C": 
				button_c_pressed = !button_c_pressed
				print("button c: " + str(button_c_pressed))
		
		if(button_a_pressed==true && button_b_pressed==false && button_c_pressed==true):
			open_escape_door()
		else:
			close_escape_door()	
			
func open_escape_door():
	get_node("/root/MainScene/Door").position = Vector2(139, 149)
		
		
func close_escape_door():
	get_node("/root/MainScene/Door").position = Vector2(217, 71)
