extends Node
class_name Loader

enum State {
	IDLE,
	LOADING,
	SUCCEEDED,
	FAILED,
	CANCELLED
}

var _res_id: String
var _done_cb: Callable
var _update_cb: Callable
var _param

var _state: State = State.IDLE
var _progress: float = 0.0
var _result = null #记一个引用，这样可以不释放资源
var progress: Array = []
	
func start(
	res_id: String,
	done_cb: Callable = Callable(),
	update_cb: Callable = Callable(),
	param = null
) -> void:
	_res_id = res_id
	_done_cb = done_cb
	_update_cb = update_cb
	_param = param
	_state = State.LOADING
	_progress = 0.0
	_result = null
	ResourceLoader.load_threaded_request(_res_id)

func _process(_delta: float) -> void:
	if _state != State.LOADING:
		return

	var status := ResourceLoader.load_threaded_get_status(_res_id, progress)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if progress.size() > 0:
				_progress = progress[0]
			if _update_cb.is_valid():
				_update_cb.call(_progress)

		ResourceLoader.THREAD_LOAD_LOADED:
			_finish(ResourceLoader.load_threaded_get(_res_id))

		ResourceLoader.THREAD_LOAD_FAILED:
			_finish(null)

func _finish(res) -> void:
	if _state != State.LOADING:
		return
	set_process(false)
	_state = State.SUCCEEDED if res!=null else State.FAILED
	_progress = 1.0
	_result = res

	if _done_cb.is_valid():
		_done_cb.call(res, _param)

func dispose() -> void:
	if _state == State.LOADING:
		_state = State.CANCELLED
	set_process(false)
	queue_free()
