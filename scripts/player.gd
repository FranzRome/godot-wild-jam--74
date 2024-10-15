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


func _interact():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + _last_direction * _interaction_distance, collision_mask, [self])
	print(query.collision_mask)
	query.collide_with_areas = true 
	var result = space_state.intersect_ray(query)
	if(!result.is_empty()):
		print("hit")
	



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
	
func execute_interactions():
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"toggle button A": print("premuto leva A")
			"toggle button B": print("premuto leva B")
			"toggle button C": print("premuto leva C")
			
		
