extends Node

signal puzzle_trigger_event(is_puzzle_right: bool)
signal silver_dagger_chest_opened()

@onready var all_interactions = []

var button_a_pressed = false
var button_b_pressed = false
var button_c_pressed = false

var interact_label = ""

var door_animation_timer_max = 2
var door_animation_timer = 2
@export var is_door_animating = false

enum INTERACT_OBJECTS {
	LEVER,
	TREASURE_CHEST
}

func _process(delta: float):
	if(is_door_animating):
		door_animation_timer -= delta
		if(door_animation_timer <= 0):
			is_door_animating = false
			door_animation_timer = door_animation_timer_max

func execute_interactions():
	# Calls the interact function of the lever
	if is_door_animating:
		return
	if all_interactions:
		var current_interaction = all_interactions[0]
		if(current_interaction.interact_value == INTERACT_OBJECTS.LEVER):
			interact_lever(current_interaction)
		elif(current_interaction.interact_value == INTERACT_OBJECTS.TREASURE_CHEST):
			interact_treasure_chest(current_interaction)		
			
var is_silver_dagger_chest_open = false

func interact_treasure_chest(current_interaction):
	if(is_silver_dagger_chest_open == false && current_interaction.interact_type == InteractAreaTreasureChest.WEAPON_TYPE.SILVER_DAGGER):
		silver_dagger_chest_opened.emit()
		is_silver_dagger_chest_open = true;
	
		
			
			
func interact_lever(current_interaction):
	var lever_active = current_interaction.interact()
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
		puzzle_trigger_event.emit(true)
	else:
		puzzle_trigger_event.emit(false)			

			
func on_player_enter_area(area: Area2D):
	all_interactions.insert(0, area)
	update_visual()
	return interact_label
	
func on_player_exit_area(area: Area2D):
	all_interactions.erase(area)
	update_visual()
	return interact_label

func update_visual():
	if(all_interactions):
		interact_label = all_interactions[0].interact_label
	else:
		interact_label = ""	
			
