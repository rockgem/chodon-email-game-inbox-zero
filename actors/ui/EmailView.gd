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
	
	var i = load('res://actors/ui/MessageDeletedPopup.tscn').instantiate()
	ManagerGame.pop_to_ui.emit(i)
	
	queue_free()


func _on_ignore_pressed() -> void:
	data['status'] = 'ignored'
	
	queue_free()


func _on_reply_pressed() -> void:
	data['status'] = 'replied'
	
	queue_free()
