extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.res.load("res://ui/PanelStart.tscn",loaddone) # Replace with function body.
	game.res.load_multi([
		"res://ui/PanelStart.tscn",
		"res://ui/PanelStart.tscn"],singleDone,allDone)

func singleDone(res_id: String, ok: bool, res: Resource):
	pass	

func allDone(ok,res):
	for k in res:
		print(k, res[k])
	
	
func loaddone(ok,res:PackedScene,_param):
	var obj = res.instantiate()
	add_child(obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
