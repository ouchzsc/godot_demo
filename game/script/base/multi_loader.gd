extends Node
class_name MultiLoader

signal single_done(res_id: String, ok: bool, res: Resource)
signal all_done(ok: bool, results: Dictionary)

var _total := 0
var _finished := 0
var _success := true
var _results := {}
var _loaders: Array[Loader] = []
var _canceled := false

func start(
	res_ids: Array[String],
	single_done_cb: Callable = Callable(),
	all_done_cb: Callable = Callable(),
	param = null
) -> void:
	_total = res_ids.size()

	if _total == 0:
		if all_done_cb.is_valid():
			all_done_cb.call(true, {})
		queue_free()
		return

	if single_done_cb.is_valid():
		single_done.connect(single_done_cb)

	if all_done_cb.is_valid():
		all_done.connect(all_done_cb)

	for res_id in res_ids:
		var loader = game.res.load(
			res_id,
			func(ok, res, _param):
				if _canceled:
					return

				_finished += 1

				if ok:
					_results[res_id] = res
				else:
					_success = false

				single_done.emit(res_id, ok, res)

				if _finished == _total:
					all_done.emit(_success, _results)
					queue_free(),
			Callable(),
			param
		)

		_loaders.append(loader)

func free() -> void:
	_canceled = true

	for l in _loaders:
		if is_instance_valid(l):
			l.queue_free()

	_loaders.clear()
	queue_free()

func _exit_tree():
	# 保证外部直接 queue_free() 也能正确清理
	free()
