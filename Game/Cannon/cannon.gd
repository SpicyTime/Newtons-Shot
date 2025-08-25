extends Node2D
@export var shot_force: int = 250
@export var player_gravity_scale = 1.0
@export var max_points: int = 10
var rotating_left: bool = false
var rotating_right: bool = false
var shot: bool = false
@onready var cannon_sprite: Sprite2D = $CannonSprite
@onready var trajectory_line: TrajectoryLine = $TrajectoryLine

func _physics_process(delta: float) -> void:
	_handle_input()
	if rotating_left or rotating_right:
		_rotate_cannon(delta)
		
	if shot:
		SignalBus.cannon_fired.emit(cannon_sprite.rotation - PI / 2, shot_force)
		
		get_parent().camera_follow_player()
	var cannon_direction: Vector2 = Vector2(cos(cannon_sprite.rotation - PI / 2), sin(cannon_sprite.rotation - PI / 2))
	trajectory_line.update_trajectory(cannon_direction, shot_force, 980 * player_gravity_scale, max_points, delta)
	
	
func _handle_input() -> void:
	
	rotating_left = Input.is_action_pressed("rotate_left")
	rotating_right = Input.is_action_pressed("rotate_right")
	shot = Input.is_action_just_pressed("shoot")
	
	
func _rotate_cannon(delta: float) -> void:
	var rotation_amount = 6 * delta
	if rotating_left:
		cannon_sprite.rotation -= rotation_amount
	else:
		cannon_sprite.rotation += rotation_amount
		
	var min_value: float = 0.5
	var max_value: float = PI / 2.25
	cannon_sprite.rotation = clampf(cannon_sprite.rotation, min_value, max_value) 
