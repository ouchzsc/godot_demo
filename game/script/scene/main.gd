extends Node

var loader: Loader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#game.ui_mgr.load("res://ui/PanelStart.tscn")
	game.ui_mgr.loadRes(preload("res://ui/PanelStart.tscn"))
	#game.ui_mgr.loadRes(load("res://ui/PanelStart.tscn"))
