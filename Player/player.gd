extends RigidBody2D
var is_in_cannon: bool = true 

func _ready() -> void:
	SignalBus.cannon_fired.connect(_on_cannon_fired)
	
	
func apply_cannon_force(direction: Vector2, force: float):
	if is_in_cannon:
		freeze = false
		linear_velocity = direction * force


func _on_cannon_fired(cannon_rotation: float, force: float) -> void:
	var shot_direction = Vector2(cos(cannon_rotation), sin(cannon_rotation) )
	print(shot_direction )
	apply_cannon_force(shot_direction, force)
	
