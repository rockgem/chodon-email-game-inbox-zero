extends Node


signal pop_to_ui(instance)
signal email_viewed(data)
signal email_deleted(data)
signal next_day_activated
signal transition_step_finished
signal transition_finished

var emails_data = {}

var global_main_ref = null

func _ready() -> void:
	emails_data = get_data("res://reso/data/emails.json")


func get_data(path):
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data


func fade_in():
	$Transition.visible = true
	$Transition/Control.modulate.a = 0.0
	$Transition/Control/Label.text = 'Shutting down...'
	
	var duration = 1.0
	
	var t = create_tween()
	t.step_finished.connect(on_step_finished)
	t.tween_property($Transition/Control, 'modulate:a', 1.0, duration)
	t.tween_property($Transition/Control, 'modulate:a', 0.0, duration).set_delay(3.0)
	#t.tween_callback($Transition/Control/Label.set_text.bind('Welcome back'))
	
	await t.finished
	
	$Transition.visible = false


#func fade_out():
	#$Transition.visible = true
	#$Transition/Control.modulate.a = 1.0
	#
	#var t = create_tween()
	#t.step_finished.connect(on_step_finished)
	#t.tween_property($Transition/Control, 'modulate:a', 0.0, 1.0)
	#
	#await t.finished
	#$Transition.visible = false


func on_step_finished(idx):
	transition_step_finished.emit()
