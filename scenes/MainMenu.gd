extends Control


func play():
	ManagerGame.fade_in_with_text('Signing In...')
	await ManagerGame.transition_step_finished
	
	get_tree().change_scene_to_file('res://scenes/Main.tscn')


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and !event.pressed:
		play()
