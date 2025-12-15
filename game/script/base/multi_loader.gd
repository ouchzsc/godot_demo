extends Node
class_name MultiLoader
var _total := 0
var _finished := 0
var _success := true
var _results := {}
var _loaders: Array[Loader] = []
var _canceled := false

func start(
	res_ids: Array[String],
	single_done: Callable,
	all_done: Callable,
	param = null
) -> void:
	_total = res_ids.size()

	if _total == 0:
		if all_done.is_valid():
			all_done.call(true, {})
		queue_free()
		return

	for i in range(res_ids.size()):
		var index := i
		var res_id = res_ids[index]
		var loader = game.res.load(
			res_id,
			func(res, _param):
				if _canceled:
					return
				_finished += 1
				if res!=null:
					_results[index] = res
				else:
					_success = false
				if single_done.is_valid():
					single_done.call(index, res, _param)
				if _finished == _total:
					if all_done.is_valid():
						all_done.call(_success, _results, _param)
					set_process(false),
			Callable(),
			param
		)
		_loaders.append(loader)

func dispose() -> void:
	if _canceled:
		return
	_canceled = true
	for l in _loaders:
		l.dispose()
	_loaders.clear()
	queue_free()
