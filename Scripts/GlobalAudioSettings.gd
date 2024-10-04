extends Node

var vol = 0

func set_volume(db_value):
	$AudioStreamPlayer.volume_db = db_value
	vol = db_value
