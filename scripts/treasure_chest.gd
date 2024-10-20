class_name  TreasureChest extends Area2D

enum WEAPON_TYPE {
	SILVER_DAGGER,
	HOLY_WATER,
	SILVER_BULLET
}

@export var interact_label = "open"
@export var interact_type: WEAPON_TYPE = WEAPON_TYPE.SILVER_DAGGER
@onready var interact_value = PuzzleManager.INTERACT_OBJECTS.TREASURE_CHEST

@onready var animated_sprite : AnimatedSprite2D = %AnimatedSprite2D

var is_treasure_box_open = false



func _ready():
	PuzzleManager.silver_chest_opened.connect(change_visual)


func change_visual():
	if(is_treasure_box_open):
		return
	animated_sprite.play("default")
		
