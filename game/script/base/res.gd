extends Node
class_name Res

func load(
	res_id: String,
	load_done: Callable = Callable(),
	load_update: Callable = Callable(),
	param = null
) -> Loader:
	var loader := Loader.new()
	loader.name = res_id
	loader.start(res_id, load_done, load_update, param)
	self.add_child.call_deferred(loader)
	return loader

func load_multi(
	res_ids: Array[String],
	single_done: Callable = Callable(),
	all_done: Callable = Callable(),
	param = null
) -> MultiLoader:
	var multi := MultiLoader.new()
	multi.name = "MultiLoader"
	add_child.call_deferred(multi)
	multi.start(res_ids, single_done, all_done, param)
	return multi
