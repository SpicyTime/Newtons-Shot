class_name Player
extends RigidBody2D
const CANNON_X: int = -102
const GROUND_LINE: int = 75

var is_in_cannon: bool = true 
var original_position: Vector2 = Vector2.ZERO
var distance_traveled: int = 0
var max_height: int = -INF 
var current_bounce_offables_entered: Array[Area2D] = []

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("bounce") and current_bounce_offables_entered.size() != 0:
			var bounce_offable_component: BounceOffableComponent =  current_bounce_offables_entered[0].find_child("BounceOffableComponent")
			bounce_offable_component.apply_bounce_force(self)
	
func _ready() -> void:
	original_position = global_position
	SignalBus.cannon_fired.connect(_on_cannon_fired)
	SignalBus.bounce_offable_entered.connect(_on_bounce_offable_entered)
	SignalBus.bounce_offable_exited.connect(_on_bounce_offable_exited)

	
func _process(_delta: float) -> void:
	var height = _calc_height()
	var _distance = _calc_distance()
	
	if height > max_height:
		max_height = height
	
	
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
	
	
func _calc_height() -> int:
	return int(global_position.x - GROUND_LINE) * 10
	
	
func _calc_distance() -> int:
	return int(global_position.x + abs(CANNON_X)) * 10
	
	
func _on_cannon_fired(cannon_rotation: float, force: float) -> void:
	var shot_direction = Vector2(cos(cannon_rotation), sin(cannon_rotation) )
	apply_cannon_force(shot_direction, force)
	
	
func _on_bounce_offable_entered(area: Area2D):
	current_bounce_offables_entered.append(area)
	print("BounceOffable Entered")
	
func _on_bounce_offable_exited(area: Area2D):
	current_bounce_offables_entered.erase(area)
