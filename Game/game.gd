extends Node2D

func _ready() -> void:
	var subpixel_camera: SubpixelCamera = find_child("SubpixelCamera")
	var player: RigidBody2D = find_child("Player")
	subpixel_camera.follow_node(player)
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		SignalBus.game_reset.emit()
		for child in get_children(true):
			if child.has_method("reset"):
				child.reset()
	
