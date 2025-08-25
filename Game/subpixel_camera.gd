class_name SubpixelCamera
extends Camera2D
@export var pixels_per_unit: int = 1
@export var snap_to_pixels: bool = true
@export var smoothing_enabled: bool = false
@export var smoothing_speed: float = 5.0
var cancel_follow: bool = false
var original_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	original_position = global_position
	position_smoothing_enabled = smoothing_enabled
	if position_smoothing_enabled:
		position_smoothing_speed = smoothing_speed
	
	#move_to(Vector2(100, 100), 10.0)
	#lerp_to(Vector2(100, 100), 0.01)
	
	
func _process(delta: float) -> void:
	if snap_to_pixels:
		var snapped: Vector2 = (global_position * pixels_per_unit).round()
		global_position = snapped
	
	
func follow_node(node: Node2D, offset: Vector2 = Vector2.ZERO, should_lerp: bool = false) -> void:
	var position_reached: bool = false
	while not cancel_follow:
		var target_position: Vector2 = node.global_position + offset
		# If the position has not been reached we move the camera, either learping or not
		if not position_reached:
			if not should_lerp:
				move_to(target_position)
			else:
				lerp_to(target_position)
		# Checks if the target position has been reached and sets the boolean accordingly
		if global_position == target_position:
			position_reached = true
		else:
			position_reached = false
			
		await get_tree().process_frame
# Asynchornously linearly moves the subpixel camera to the target position at a desired speed
func move_to(target_position: Vector2 = Vector2.ZERO, camera_speed: float = 10.0, asynchornously: bool = false) -> void:
	if asynchornously:
		while target_position.distance_to(global_position) > 1:
			print(target_position.distance_to(global_position))
			global_position += global_position.direction_to(target_position) * camera_speed
			
			await get_tree().process_frame
		global_position = target_position
	else:
		if target_position.distance_to(global_position) > 5:
			global_position += global_position.direction_to(target_position) * camera_speed
		else:
			global_position = target_position
	
func lerp_to(target_position: Vector2 = Vector2.ZERO, lerp_weight: float = 0.01, asynchornously: bool = false) -> void:
	if asynchornously:
		while target_position.distance_to(global_position) > 1:
			global_position = global_position.lerp(target_position, lerp_weight)
			await get_tree().process_frame
	else:
		pass

func reset() -> void:
	global_position = original_position
