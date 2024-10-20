class_name  InteractAreaTreasureChest extends Area2D

enum WEAPON_TYPE {
	SILVER_DAGGER,
	HOLY_WATER,
	SILVER_BULLET
}

@export var interact_label = "Open"
@export var interact_type: WEAPON_TYPE = WEAPON_TYPE.SILVER_DAGGER
@onready var interact_value = PuzzleManager.INTERACT_OBJECTS.TREASURE_CHEST



		
