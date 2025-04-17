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
					ManagerGame.run_action_script(data[flag_id][1])
					
					# most run_script tags are just scripts where we add new emails immediately, or
					# adding them for the next day, so we run this function to refresh the emails being displayed
					#ManagerGame.global_main_ref.refresh_emails_display()
					
				'add_sanity': ManagerGame.global_main_ref.sanity = clamp(ManagerGame.global_main_ref.sanity + 10, 0, 100)
				'reduce_sanity': ManagerGame.global_main_ref.sanity = clamp(ManagerGame.global_main_ref.sanity - 10, 0, 100)
				'add_security': ManagerGame.global_main_ref.job_security = clamp(ManagerGame.global_main_ref.job_security + 10, 0, 100)
				'reduce_security': ManagerGame.global_main_ref.job_security = clamp(ManagerGame.global_main_ref.job_security - 10, 0, 100)
				'game_over': ManagerGame.global_main_ref.game_over()
	
	# checks the email's type and increment values
	# this is where we can track of which emails has been interacted with
	# example; the HR emails, when constantly ignored will increment "ignored_hr_letters"
	# in which the game checks every start of the day and will execute the necessary functions
	var type = data['type'] # "hr", "work", "spam", "phishing", "important", "personal"
	match type:
		'hr':
			if flag_id == 'on_delete' or flag_id == 'on_ignore':
				ManagerGame.global_main_ref.ignored_hr_letters += 1
		'work':
			if flag_id == 'on_delete' or flag_id == 'on_ignore':
				ManagerGame.global_main_ref.ignored_work_letters += 1
		'spam':
			if flag_id == 'on_reply':
				ManagerGame.global_main_ref.replied_phishing_letters += 1
		'phishing':
			if flag_id == 'on_reply':
				ManagerGame.global_main_ref.replied_phishing_letters += 1
		'personal':
			if flag_id == 'on_reply':
				ManagerGame.global_main_ref.replied_personal_letters += 1
		'important':
			if flag_id == 'on_ignore' or flag_id == 'on_delete':
				ManagerGame.global_main_ref.ignored_important_letters += 1


func _on_delete_pressed() -> void:
	data['status'] = 'deleted'
	
	execute_flag('on_delete')
	
	var i = load('res://actors/ui/MessageDeletedPopup.tscn').instantiate()
	ManagerGame.pop_to_ui.emit(i)
	
	ManagerGame.email_deleted.emit(data)
	
	Sfx.play_sound('Click')
	
	queue_free()


func _on_ignore_pressed() -> void:
	data['status'] = 'ignored'
	
	execute_flag('on_ignore')
	
	Sfx.play_sound('Click')
	
	match data['type']:
		'hr': pass
		'spam': pass
		'work': pass
		'phishing': pass
		'important': pass
	
	queue_free()


func _on_reply_pressed() -> void:
	data['status'] = 'replied'
	
	execute_flag('on_reply')
	
	Sfx.play_sound('Click')
	
	queue_free()


func _on_close_pressed() -> void:
	Sfx.play_sound('Click')
	
	queue_free()
