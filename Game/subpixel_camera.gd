class_name SubpixelCamera
extends Camera2D
@export var pixels_per_unit: int = 1
@export var snap_to_pixels: bool = true
@export var smoothing_enabled: bool = false
@export var smoothing_speed: float = 5.0

func _ready() -> void:
	position_smoothing_enabled = smoothing_enabled
	if position_smoothing_enabled:
		position_smoothing_speed = smoothing_speed
		
	#move_to(Vector2(100, 100), 10.0)
	#lerp_to(Vector2(100, 100), 0.01)
	
func _process(delta: float) -> void:
	if snap_to_pixels:
		var snapped: Vector2 = (global_position * pixels_per_unit).round()
		global_position = snapped
	
	
# Asynchornously linearly moves the subpixel camera to the target position at a desired speed
func move_to(target_position: Vector2 = Vector2.ZERO, camera_speed: float = 10.0) -> void:
	while target_position.distance_to(global_position) > 1:
		print(target_position.distance_to(global_position))
		global_position += global_position.direction_to(target_position) * camera_speed
		
		await get_tree().process_frame
	global_position = target_position
	
	
func lerp_to(target_position: Vector2 = Vector2.ZERO, lerp_weight: float = 0.5) -> void:
	while target_position.distance_to(global_position) > 1:
		global_position = global_position.lerp(target_position, lerp_weight)
		await get_tree().process_frame
