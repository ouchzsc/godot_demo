extends Node

var loader: Loader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loader = game.res.load("res://ui/PanelStart.tscn")
	await loader.finished
	var asset: PackedScene = loader.asset
	var node = asset.instantiate()
	add_child.call_deferred(node)
	game.events.click_start.connect(onclick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func onclick():
	game.res.load("res://level/test.tscn", onTestLoadDone)

func onTestLoadDone(res: PackedScene, _param):
	get_tree().change_scene_to_packed(res)
