extends Node2D
@onready var terrain_piece_1: TerrainPiece = $TerrainPiece1
@onready var terrain_piece_2: TerrainPiece = $TerrainPiece2

func _ready() -> void:
	terrain_piece_1.replace_by(preload("res://Terrain System/Starting Piece/starting_terrain.tscn").instantiate())  
	
	
