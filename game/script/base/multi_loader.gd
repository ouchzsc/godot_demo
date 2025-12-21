extends Node
class_name MultiLoader
signal finished(success: bool, results: Dictionary, param)

var _total := 0
var _finished_count := 0
var _is_success := true
var _results := {}
var _loaders: Array[Loader] = []
var _is_canceled := false
var _param

func start(res_ids: Array[String], param = null) -> void:
	_param = param
	_total = res_ids.size()
	_finished_count = 0
	_is_success = true
	_results = {}
	_loaders.clear()

	# 处理空列表的情况
	if _total == 0:
		_finish_all()
		return

	for i in range(_total):
		var index := i
		var res_id = res_ids[index]
		var loader: Loader = game.res.load(res_id, null)
		_loaders.append(loader)
		loader.finished.connect(func(res: Resource, _p):
			_on_single_loader_done(index, res)
		)
		loader.failed.connect(func():
			_is_success = false
		)

func _on_single_loader_done(index: int, res: Resource) -> void:
	if _is_canceled: return
	
	_finished_count += 1
	if res != null:
		_results[index] = res
	else:
		_is_success = false
	if _finished_count == _total:
		_finish_all()

func _finish_all() -> void:
	finished.emit(_is_success, _results, _param)
	queue_free()

func cancel() -> void:
	if _is_canceled: return
	_is_canceled = true
	for l in _loaders:
		if is_instance_valid(l):
			l.cancel()
	_loaders.clear()
	queue_free()
