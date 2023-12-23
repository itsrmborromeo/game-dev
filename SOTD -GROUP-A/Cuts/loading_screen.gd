extends CanvasLayer
@onready var loading = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	ProgressManager.progress(1)
