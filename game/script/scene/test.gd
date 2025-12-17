extends Node
var mloader:MultiLoader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.events.click_start.connect(onclick)
	var loader = game.res.load_multi([
		"res://ui/PanelStart.tscn",
		"res://ui/PanelStart.tscn"])# Replace with function body.
	await loader.finished
	var res = loader._results
	var a :PackedScene = res[0]
	print(a,res[1])
	
func onclick():
	mloader.cancel()

func singleDone(_i, _res, _param):
	print(_res)	

func allDone(_success, res, _param):
	print(res[0]==res[1])
	
	
func loaddone(_res:PackedScene,_param):
	var obj = _res.instantiate()
	add_child(obj)
	print(_res)

func _process(_delta: float) -> void:
	pass
