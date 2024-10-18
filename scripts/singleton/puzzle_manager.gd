extends Node


@onready var all_interactions = []

var button_a_pressed = false
var button_b_pressed = false
var button_c_pressed = false

var interact_label = ""


func _process(delta: float):
	if(is_door_animating):
		door_animation_timer-= delta
		if(door_animation_timer<= 0):
			is_door_animating = false
			door_animation_timer = door_animation_timer_max

func execute_interactions():
	# Calls the interact function of the lever
	if(is_door_animating):
		return
	if all_interactions:
		var current_interaction = all_interactions[0]
		var lever_active = current_interaction.interact_lever()
		match current_interaction.interact_type:
			InteractablePuzzleLever.InteractableType.BUTTON_A:
				button_a_pressed = lever_active
				print("button a: " +  str(lever_active) )
			InteractablePuzzleLever.InteractableType.BUTTON_B:
				button_b_pressed = lever_active
				print("button b: " + str(lever_active))
			InteractablePuzzleLever.InteractableType.BUTTON_C:
				button_c_pressed = lever_active
				print("button c: " + str(lever_active))
			
		
		if(button_a_pressed==true && button_b_pressed==false && button_c_pressed==true):
			open_escape_door()
		else:
			close_escape_door()	
			
			
			
func on_player_enter_area(area: Area2D):
	all_interactions.insert(0, area)
	update_visual()
	return interact_label
	
func on_player_exit_area(area: Area2D):
	all_interactions.erase(area)
	update_visual()
	return interact_label

func update_visual():

	print("update label")

	if(all_interactions):
		interact_label = all_interactions[0].interact_label
	else:
		interact_label = ""	
			

#region Door stuff

var door_open = false
var door_animation_timer_max = 2
var door_animation_timer = 2
var is_door_animating = false

func open_escape_door():
	if door_open:
		return
	door_open = true
	is_door_animating = true
	var tween = create_tween()
	var door = get_node("/root/MainScene/Environment/Interactables/Door")
	door.position = Vector2(217, 71)
	tween.tween_property(door, ^"position:y", 139, 0.5)
	tween.tween_property(door, ^"position:x", 149, 0.5)
	tween.tween_property(door, ^"position", Vector2(149, 139), 0.1)
	
		
		
func close_escape_door():
	if not door_open:
		return
	door_open = false
	is_door_animating = true
	var tween = create_tween()
	var door = get_node("/root/MainScene/Environment/Interactables/Door")
	door.position = Vector2(149, 139)
	tween.tween_property(door, ^"position:x", 217, 0.5)
	tween.tween_property(door, ^"position:y", 71, 0.5)
	tween.tween_property(door, ^"position", Vector2(217, 71), 0.1)

#endregion
