extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ButtonStart.pressed.connect(click_start)
	$ButtonExit.pressed.connect(click_exit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func click_start():
	game.scene_mgr.load("res://level/test.tscn")
	queue_free()

func click_exit():
	get_tree().quit()
