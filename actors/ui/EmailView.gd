extends Control


var data = {}


func _ready() -> void:
	$Panel/Panel/HBoxContainer/Subject.text = data['subject']
	$Panel/Panel/Date.text = data['date']
	$Panel/Panel/From.text = 'From: %s %s' % [data['sender_name'], data['sender_email']]
	$Panel/Panel/To.text = 'To: %s %s' % [data['to_name'], data['to']]
	$Panel/Panel/Body.text = '%s' % data['body']


func _on_delete_pressed() -> void:
	data['status'] = 'deleted'
	
	# check if it has a on_delete flag
	if data.has('on_delete'):
		match data['on_delete'][0]:
			'run_script':
				var sc = load(data['on_delete'][1]).instantiate()
				add_child(sc)
				
				ManagerGame.global_main_ref.refresh_emails_display()
			'add_sanity': pass
			'reduce_sanity': pass
			'add_security': pass
			'reduce_security': pass
	
	var i = load('res://actors/ui/MessageDeletedPopup.tscn').instantiate()
	ManagerGame.pop_to_ui.emit(i)
	
	queue_free()


func _on_ignore_pressed() -> void:
	data['status'] = 'ignored'
	
	queue_free()


func _on_reply_pressed() -> void:
	data['status'] = 'replied'
	
	queue_free()
