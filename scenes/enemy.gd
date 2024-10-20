extends Node2D

@export var speed: float = 5
@export var view_range: float = 100
@export var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.distance_to(player.position) <= view_range:
		_follow_player(delta)

func _follow_player(delta):
	var direction = (player.position - position).normalized()  # Direzione verso il giocatore
	position += direction * speed * delta  # Imposta la velocità in base alla direzione
