extends Node
@onready var ui_canvas_layer: CanvasLayer = $UICanvasLayer

func _ready() -> void:
	UiManager.set_up_ui(ui_canvas_layer)
