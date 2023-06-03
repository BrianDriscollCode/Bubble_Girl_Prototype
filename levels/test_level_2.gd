extends Node2D

signal level_changed(level_name)

export (String) var level_name = "level_2"

func next_level():

	emit_signal("level_changed", level_name)
	
