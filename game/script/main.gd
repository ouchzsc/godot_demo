extends Node

var loader:Loader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loader = game.res.load("res://ui/PanelStart.tscn",loaddone)
	game.events.click_start.connect(onclick)

func loaddone(res:PackedScene,_param):
	add_child(res.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func onclick():
	game.res.load("res://level/test.tscn",onTestLoadDone)

func onTestLoadDone(res:PackedScene,_param):
	get_tree().change_scene_to_packed(res)
