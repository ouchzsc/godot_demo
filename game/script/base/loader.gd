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
var _done_cb: Callable = Callable()
var _update_cb: Callable = Callable()
var _param

var _state: State = State.IDLE
var _progress: float = 0.0
var _result = null
	
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
	print("process")
	if _state != State.LOADING:
		return

	var progress := []
	var status := ResourceLoader.load_threaded_get_status(_res_id, progress)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			_progress = progress[0]
			if _update_cb.is_valid():
				_update_cb.call(_progress)

		ResourceLoader.THREAD_LOAD_LOADED:
			_finish(true, ResourceLoader.load_threaded_get(_res_id))

		ResourceLoader.THREAD_LOAD_FAILED:
			_finish(false, null)

func _finish(success: bool, res) -> void:
	if _state != State.LOADING:
		return

	set_process(false)
	_state = State.SUCCEEDED if success else State.FAILED
	_progress = 1.0
	_result = res

	if _done_cb.is_valid():
		_done_cb.call(success, res, _param)

func free() -> void:
	if _state == State.LOADING:
		_state = State.CANCELLED

	set_process(false)
	queue_free()

func get_state() -> State:
	return _state

func get_progress() -> float:
	return _progress

func get_result():
	return _result
