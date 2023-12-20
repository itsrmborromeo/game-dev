extends Node2D

@export var heart1 : Texture2D
@export var heart0 : Texture2D

@onready var heart_1 = $heart1
@onready var heart_2 = $heart2
@onready var heart_3 = $heart3

func _process(_delta):
	if HealthManager.currentHP == 3:
		heart_3.texture = heart1
	elif HealthManager.currentHP < 3:
		heart_3.texture = heart0
		
	if HealthManager.currentHP == 2:
		heart_2.texture = heart1
	elif HealthManager.currentHP < 2:
		heart_2.texture = heart0
		
	if HealthManager.currentHP == 1:
		heart_3.texture = heart1
	elif HealthManager.currentHP < 1:
		heart_3.texture = heart0
