extends Control


var day = 1
var emails = []


func _ready() -> void:
	ManagerGame.pop_to_ui.connect(on_pop_to_ui)
	
	load_day_emails()



func load_day_emails():
	pass


func on_pop_to_ui(instance):
	
	$Popup.add_child(instance)
