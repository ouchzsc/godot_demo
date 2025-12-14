extends Node

var loader:Loader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loader = game.res.load("res://ui/PanelStart.tscn",loaddone)
	game.events.click_start.connect(onclick)

func loaddone(ok,res:PackedScene,_param):
	var obj = res.instantiate()
	add_child(obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onclick():
	loader.free()
