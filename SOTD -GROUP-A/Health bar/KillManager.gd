extends Node
var kills : int
signal on_kill_counter
func _ready():
	kills = 0

func add_kill(value):
	kills += value
	
	on_kill_counter.emit(kills)
	
func killrst(val):
	kills=val
