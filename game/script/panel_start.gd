extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ButtonStart.pressed.connect(click_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func click_start():
	print("start")
	game.events.click_start.emit()
