extends Control


func _process(delta: float):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
