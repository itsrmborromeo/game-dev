extends Node2D
var load =preload("res://Cuts/loading_screen.tscn")
func _ready():
	$Area2D/AnimatedSprite2D.play("portal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.transition_to_scene(load.resource_path)
