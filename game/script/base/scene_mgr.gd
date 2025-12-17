extends Node
class_name SceneMgr
var isLoading = false

func load(scene_path: String):
	if isLoading:
		return
	isLoading = true
	var loader = game.res.load(scene_path)
	await loader.finished
	var scene: PackedScene = loader.asset
	get_tree().change_scene_to_packed(scene)
	await get_tree().scene_changed
	isLoading = false
