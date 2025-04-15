extends Control


var data = {}


func _ready() -> void:
	$Panel/Panel/Subject.text = data['subject']
	$Panel/Panel/Date.text = data['date']
	$Panel/Panel/From.text = 'From: %s %s' % [data['sender_name'], data['sender_email']]
	$Panel/Panel/To.text = 'To: %s %s' % [data['to_name'], data['to']]
	$Panel/Panel/Body.text = '%s' % data['body']


func _on_delete_pressed() -> void:
	pass # Replace with function body.


func _on_ignore_pressed() -> void:
	pass # Replace with function body.


func _on_reply_pressed() -> void:
	pass # Replace with function body.
