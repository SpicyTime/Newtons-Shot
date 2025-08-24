class_name TrajectoryLine
extends Line2D


func update_trajectory(direction: Vector2, force: float, gravity: float, max_points: int, delta: float) -> void:
	var vel = direction * force
	var pos: Vector2 = Vector2.ZERO
	clear_points()
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
		
