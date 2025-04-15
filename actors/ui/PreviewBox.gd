extends HBoxContainer


var data = {}


func _on_sender_name_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and !event.pressed:
		data['is_viewed'] = true
		
		$SenderName.set('theme_override_fonts/font', load("res://reso/styles/IBMPlexMono-Regular.ttf"))
		$Body.set('theme_override_fonts/font', load("res://reso/styles/IBMPlexMono-Regular.ttf"))
		
		var i = load('res://actors/ui/EmailView.tscn').instantiate()
		i.data = data
		
		ManagerGame.email_viewed.emit(data)
		ManagerGame.pop_to_ui.emit(i)
