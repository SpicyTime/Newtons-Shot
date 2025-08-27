class_name BounceOffableComponent
extends Node
@export var bounce_force_x: float = 0
@export var bounce_force_y: float = 0

func _ready() -> void:
	var parent: Node2D = get_parent()
	if not parent is Area2D:
		push_error("BounceOffableComponent does not have Area2D as parent")
	parent = parent as Area2D
	parent.body_entered.connect(_on_bounce_offable_area_body_entered)
	parent.collision_layer = Constants.BOUNCE_OFFABLE_LAYER
	
	
func apply_bounce_force(body: RigidBody2D) -> void:
	body.apply_central_impulse(Vector2(bounce_force_x, bounce_force_y))
	
	
func _on_bounce_offable_area_body_entered(_body: Node2D) -> void:
	SignalBus.bounce_offable_entered.emit(get_parent())
	
	
func _on_bounce_offable_area_body_exited(_body: Node2D) -> void:
	SignalBus.bounce_offable_exited.emit(get_parent())
