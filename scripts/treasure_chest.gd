extends Node2D


var is_treasure_box_open = false
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	PuzzleManager.silver_dagger_chest_opened.connect(change_visual)


func change_visual():
	if(is_treasure_box_open):
		return
	animation_player.play("opening_chest")
	is_treasure_box_open = true
	
