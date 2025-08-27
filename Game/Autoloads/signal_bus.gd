extends Node
# Game
signal game_reset
# Cannon 
signal cannon_fired(rotation: float, force: float)
# Bounce-offables
signal bounce_offable_entered
signal bounce_offable_exited
