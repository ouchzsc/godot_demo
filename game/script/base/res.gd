extends Node
class_name Res

func load(
	res_id: String,
	param = null
) -> Loader:
	var loader := Loader.new()
	loader.name = res_id
	loader.start(res_id, param)
	self.add_child.call_deferred(loader)
	return loader

func load_multi(
	res_ids: Array[String],
	param = null
) -> MultiLoader:
	var multi := MultiLoader.new()
	multi.name = "MultiLoader"
	add_child.call_deferred(multi)
	multi.start(res_ids, param)
	return multi
