class_name InteractablePuzzleLever extends Area2D

@export var interact_label = "name"
@export var interact_type = "none"
@export var interact_value = "none"

var is_lever_active = false

func interact_lever():
	is_lever_active = !is_lever_active
	change_visual()

func change_visual():
	if is_lever_active:
		#var texture = load('res://icons/haunted.png')
		#get_parent().get_node("AnimatedSprite2D").frame = 2
		get_parent().get_node("AnimatedSprite2D").play()
		#sprite.texture = texture
	else:	
		#var texture = load('res://icons/GWJ-Full-Logo-noBG.svg')
		#get_parent().get_node("AnimatedSprite2D").frame = 0
		get_parent().get_node("AnimatedSprite2D").play_backwards()
		#var sprite: Sprite2D = get_parent().get_node("Sprite2D")
		#sprite.texture = texture
