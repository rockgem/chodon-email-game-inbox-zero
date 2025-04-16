extends Control


var data = {}


func _ready() -> void:
	$Panel/Panel/HBoxContainer/Subject.text = data['subject']
	$Panel/Panel/Date.text = data['date']
	$Panel/Panel/From.text = 'From: %s %s' % [data['sender_name'], data['sender_email']]
	$Panel/Panel/To.text = 'To: %s %s' % [data['to_name'], data['to']]
	$Panel/Panel/Body.text = '%s' % data['body']
	
	if data.has('status'):
		for b in $Panel/Buttons.get_children():
			b.disabled = true


# this function handles the stat change and handles the script loading of specific effects
# that are attached to a letter/email
# flag_id's are: on_ignore, on_delete, on_reply
func execute_flag(flag_id: String):
	if data.has(flag_id):
		if data[flag_id].is_empty() == false:
			match data[flag_id][0]:
				'run_script':
					# a run_script flag expects a parameter which is the path to the script
					# in this case, its in the array index 1
					# see scripts example located in folder reso/action_scripts/
					var sc = load(data[flag_id][1]).instantiate()
					add_child(sc)
					
					# most run_script tags are just scripts where we add new emails immediately, or
					# adding them for the next day, so we run this function to refresh the emails being displayed
					ManagerGame.global_main_ref.refresh_emails_display()
					
				'add_sanity': ManagerGame.global_main_ref.sanity += 10
				'reduce_sanity': ManagerGame.global_main_ref.sanity -= 10
				'add_security': ManagerGame.global_main_ref.job_security += 10
				'reduce_security': ManagerGame.global_main_ref.job_security -= 10


func _on_delete_pressed() -> void:
	data['status'] = 'deleted'
	
	execute_flag('on_delete')
	
	var i = load('res://actors/ui/MessageDeletedPopup.tscn').instantiate()
	ManagerGame.pop_to_ui.emit(i)
	
	ManagerGame.email_deleted.emit(data)
	
	queue_free()


func _on_ignore_pressed() -> void:
	data['status'] = 'ignored'
	
	execute_flag('on_ignore')
	
	queue_free()


func _on_reply_pressed() -> void:
	data['status'] = 'replied'
	
	execute_flag('on_reply')
	
	queue_free()


func _on_close_pressed() -> void:
	queue_free()
