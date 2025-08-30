class_name PurchaseLineSlider
extends Control
@export var tick_count: int = 10
const TICK_UID: String = "uid://bd7nybeikhr5e"
var current_bought_tick_index: int = -1
var ticks: Array[ColorRect] = []
@onready var gray_line: ColorRect = $GrayLine
@onready var red_line: ColorRect = $RedLine
@onready var green_line: ColorRect = $GreenLine
@onready var tick_container: Control = $TickContainer

func _ready() -> void:
	_initialize_ticks()
	
	
func _on_gui_input(event: InputEvent) -> void:
	var current_tick_index: int = _get_current_hover_tick_index()
	
	if event is InputEventMouse:
		if event is InputEventMouseMotion:
			if _can_purchase_at_tick(ticks[current_tick_index]):
				_snap_line_to_tick(green_line, current_tick_index)
			else:
				_snap_line_to_tick(red_line, current_tick_index)
			get_viewport().set_input_as_handled()
		elif event is InputEventMouseButton:
			get_viewport().set_input_as_handled()
	
	
func _on_mouse_exited() -> void:
	_snap_line_to_tick(red_line, current_bought_tick_index)
	
	
func _initialize_ticks() -> void:
	print("Initializing %d ticks" % tick_count)
	var length: float = gray_line.size.x
	var tick_separation_distance: float = length / tick_count
	var current_tick_pos = Vector2.ZERO
	for i in range(tick_count):
		current_tick_pos.x += tick_separation_distance
		var packed_tick_scene: PackedScene = preload(TICK_UID)
		var tick: ColorRect = packed_tick_scene.instantiate()
		current_tick_pos.y = (tick.position.y - tick.size.y / 2) + tick.size.y / 4
		tick.position = current_tick_pos
		tick_container.add_child(tick)
		ticks.append(tick)
		print("Tick position %f" % tick.position.x)
		
func _snap_line_to_tick(line: ColorRect, tick_index: int) -> void:
	if tick_index < 0:
		line.size.x = 0
		return 
	var tick: ColorRect = ticks[tick_index]
	var line_end_x: float = line.position.x  + line.size.x
		
	var length_difference: float = tick.position.x - line_end_x
	line.size.x += length_difference
	
	
func _get_current_hover_tick_index() -> int:
	var length: float = gray_line.size.x
	var tick_separation_distance: float = length / tick_count
	var nearest_tick_index: int = get_local_mouse_position().x / tick_separation_distance
	return nearest_tick_index
	
	
func _can_purchase_at_tick(tick: ColorRect) -> bool:
	return false
	
