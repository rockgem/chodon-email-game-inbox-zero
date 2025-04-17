extends Control


func _ready() -> void:
	$Panel/VBoxContainer/Sanity/ProgressBar.value = ManagerGame.global_main_ref.sanity
	$Panel/VBoxContainer/JS/ProgressBar.value = ManagerGame.global_main_ref.job_security


func _on_retry_pressed() -> void:
	ManagerGame.fade_in()
	await ManagerGame.transition_step_finished
	
	get_tree().change_scene_to_file('res://scenes/Main.tscn')


func _on_quit_pressed() -> void:
	pass # Replace with function body.
