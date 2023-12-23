extends Node2D
@onready var anim  = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("loading")
	
func play_anim(animation_name):
	anim.play(animation_name)
	
func stop_anim():
	anim.stop()
