extends Node2D


@export var time: float = 3.0

var timer: float
var active


func _ready():
	timer = 0
	active = false

func _process(delta):
	if timer > 0:
		timer -= delta
		if timer <= 0:
			timer = 0
			_on_timer_end()
			

func on_press():
	active = true
	timer = time

func _on_timer_end():
	active = false
