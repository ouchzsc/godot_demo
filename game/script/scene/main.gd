extends Node

var loader: Loader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.ui_mgr.load("res://ui/PanelStart.tscn")