extends Node


signal pop_to_ui(instance)
signal email_viewed(data)
signal next_day_activated

var emails_data = {}

var global_main_ref = null

func _ready() -> void:
	emails_data = get_data("res://reso/data/emails.json")


func get_data(path):
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data
