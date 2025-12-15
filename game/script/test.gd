extends Node
var mloader:MultiLoader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.events.click_start.connect(onclick)
	game.res.load("res://ui/PanelStart.tscn",loaddone) # Replace with function body.
	mloader = game.res.load_multi([
		"res://ui/PanelStart.tscn",
		"res://ui/PanelStart.tscn"],singleDone,allDone)

func onclick():
	mloader.dispose()

func singleDone(_i, _res, _param):
	print(_res)	

func allDone(_success, res, _param):
	print(res[0]==res[1])
	
	
func loaddone(_res:PackedScene,_param):
	var obj = _res.instantiate()
	add_child(obj)
	print(_res)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
