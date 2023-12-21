extends Node
var current_level = -1
var levels : Array =[
	preload("res://final_folder/stage_1_level_1.tscn"),
	preload("res://final_folder/stage_1_level_2.tscn"),
	preload("res://final_folder/stage_1_boss_level.tscn"),
	preload("res://final_folder/stage_2_level_1.tscn"),
	preload("res://final_folder/stage_2_level_2.tscn"),
	preload("res://final_folder/stage_2_boss_level.tscn"),
	preload("res://final_folder/stage_3_level_1.tscn"),
	preload("res://final_folder/stage_3_level_2.tscn"),
	preload("res://final_folder/stage_3_boss_level.tscn"),
	preload("res://final_folder/stage_4_level_1.tscn"),
	preload("res://final_folder/stage_4_boss_level.tscn")
]
func progress(val):
	current_level += val
	GameManager.transition_to_scene(levels[current_level].resource_path)
	
func prog_reset(rst):
	current_level = rst
