extends Node2D

var door_open = false



func _ready():
	PuzzleManager.puzzle_trigger_event.connect(on_puzzle_trigger_escape_door)


func on_puzzle_trigger_escape_door(is_puzzle_right: bool):
	if is_puzzle_right && door_open == false:
		PuzzleManager.is_door_animating = true
		open_escape_door()
		door_open = true
	elif is_puzzle_right == false && door_open == true:
		PuzzleManager.is_door_animating = true
		close_escape_door()
		door_open = false

			
func open_escape_door():	
	var tween = create_tween()
	position = Vector2(217, 71)
	tween.tween_property(self, ^"position:y", 139, 0.5)
	tween.tween_property(self, ^"position:x", 149, 0.5)
	tween.tween_property(self, ^"position", Vector2(149, 139), 0.1)		
	
	
func close_escape_door():
	var tween = create_tween()
	position = Vector2(149, 139)
	tween.tween_property(self, ^"position:x", 217, 0.5)
	tween.tween_property(self, ^"position:y", 71, 0.5)
	tween.tween_property(self, ^"position", Vector2(217, 71), 0.1)
