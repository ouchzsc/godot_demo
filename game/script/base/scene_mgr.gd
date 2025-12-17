extends Node
class_name SceneMgr

func load(scene_path: String):
	var loader = game.res.load(scene_path)
	await loader.finished
	var scene: PackedScene = loader.asset
	get_tree().change_scene_to_packed(scene)
