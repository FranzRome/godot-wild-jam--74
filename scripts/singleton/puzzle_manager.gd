extends Node

@export var door: Node2D

@onready var all_interactions = []

var button_a_pressed = false
var button_b_pressed = false
var button_c_pressed = false

var interact_label = ""

func execute_interactions():
	# Calls the interact function of the lever
	
	if all_interactions:
		var current_interaction = all_interactions[0]
		current_interaction.interact_lever()
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
			
			
			
func on_player_enter_area(area: Area2D):
	all_interactions.insert(0, area)
	update_visual()
	return interact_label
	
func on_player_exit_area(area: Area2D):
	all_interactions.erase(area)
	update_visual()
	return interact_label

func update_visual():
	print("visual updated")
	if(all_interactions):
		interact_label = all_interactions[0].interact_label
	else:
		interact_label = ""	
			
func open_escape_door():
	get_node("/root/MainScene/Environment/Interactables/Door").position = Vector2(139, 149)
		
		
func close_escape_door():
	get_node("/root/MainScene/Environment/Interactables/Door").position = Vector2(217, 71)
