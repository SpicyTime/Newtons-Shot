extends RigidBody2D
var is_in_cannon: bool = true 
var original_position: Vector2 = Vector2.ZERO
var reset_pending: bool = false
func _ready() -> void:
	original_position = global_position
	SignalBus.cannon_fired.connect(_on_cannon_fired)
	
	
func apply_cannon_force(direction: Vector2, force: float):
	if is_in_cannon:
		freeze = false
		linear_velocity = direction * force
		is_in_cannon = false
	
	
func reset() -> void:
	await get_tree().create_timer(0.0001).timeout
	position = original_position
	freeze = true
	linear_velocity = Vector2.ZERO
	is_in_cannon = true
	
	

		
		
func _on_cannon_fired(cannon_rotation: float, force: float) -> void:
	var shot_direction = Vector2(cos(cannon_rotation), sin(cannon_rotation) )
	apply_cannon_force(shot_direction, force)
