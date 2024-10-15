class_name Interactable extends Area2D

@export var interact_label = "name"
@export var interact_type = "none"
@export var interact_value = "none"

var is_leva_active = false

func interact_leva():
	is_leva_active = !is_leva_active
	change_visual()

func change_visual():
	if(is_leva_active):
		var texture = load('res://icons/icon.svg')
	
		var sprite: Sprite2D = get_parent().get_node("Sprite2D") 
		sprite.texture = texture
	else:	
		var texture = load('res://icons/haunted.png')
	
		var sprite: Sprite2D = get_parent().get_node("Sprite2D") 
		sprite.texture = texture
		
