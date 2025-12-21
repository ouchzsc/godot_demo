extends Node
class_name UIMgr
func load(path: String):
	var loader = game.res.load(path)
	await loader.finished
	var uiPrefab: PackedScene = loader.asset
	var uiNode = uiPrefab.instantiate()
	add_child.call_deferred(uiNode)

func loadRes(res: Resource):
	add_child(res.instantiate())
