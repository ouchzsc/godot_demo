extends Node
class_name Loader

signal progress_updated(value: float)
signal finished(resource: Resource, param)
signal failed()

enum State {
	IDLE,
	LOADING,
	SUCCEEDED,
	FAILED,
	CANCELLED
}

var _res_id: String
var _param
var asset
var _state: State = State.IDLE
var _progress: float = 0.0
var progress: Array = []

func start(
	res_id: String,
	param = null
) -> void:
	_res_id = res_id
	_param = param
	_state = State.LOADING
	_progress = 0.0
	
	if not ResourceLoader.exists(_res_id):
		push_error("Loader: 资源路径不存在 -> " + _res_id)
		_handle_failure()
		return
		
	ResourceLoader.load_threaded_request(_res_id)
	set_process(true)

func _process(_delta: float) -> void:
	if _state != State.LOADING:
		return
	var status := ResourceLoader.load_threaded_get_status(_res_id, progress)
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if progress.size() > 0:
				_progress = progress[0]
			progress_updated.emit(_progress)

		ResourceLoader.THREAD_LOAD_LOADED:
			var res = ResourceLoader.load_threaded_get(_res_id)
			_finish(res)

		ResourceLoader.THREAD_LOAD_FAILED:
			_handle_failure()

func _handle_failure() -> void:
	_state = State.FAILED
	failed.emit()
	_finish(null)

func _finish(res: Resource) -> void:
	if _state == State.CANCELLED:
		return
	if res != null:
		_state = State.SUCCEEDED
		_progress = 1.0
		asset = res
		finished.emit(res, _param)
	queue_free()

func cancel() -> void:
	if _state == State.LOADING:
		_state = State.CANCELLED
	queue_free()
