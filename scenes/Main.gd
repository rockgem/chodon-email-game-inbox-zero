extends Control


var day = 1
var emails = []

var ignored_work_letters = 0
var ignored_hr_letters = 0
var ignored_important_letters = 0
var replied_personal_letters = 0
var replied_phishing_letters = 0

var job_security = 100.0
var sanity = 100.0

func _ready() -> void:
	ManagerGame.pop_to_ui.connect(on_pop_to_ui)
	ManagerGame.email_viewed.connect(on_email_viewed)
	ManagerGame.email_deleted.connect(on_email_deleted)
	
	ManagerGame.global_main_ref = self
	
	load_day_emails()


func _physics_process(delta: float) -> void:
	$Stats/VBoxContainer/Sanity/ProgressBar.value = sanity
	$Stats/VBoxContainer/JS/ProgressBar.value = job_security


func refresh_emails_display():
	for child in $InboxPanel/Panel/ScrollContainer/List.get_children():
		child.queue_free()
	
	for email in emails:
		# if data has no "status" value in json, it means its new and wasn'nt interacted yet
		if email.has('status') == false:
			var i = load('res://actors/ui/PreviewBox.tscn').instantiate()
			i.data = email
			i.get_node('SenderName').text = email['sender_name']
			i.get_node('Body').text = email['body']
			
			$InboxPanel/Panel/ScrollContainer/List.add_child(i)
		else:
			# checks if the message was interacted but only display the ones that were not deleted
			if email['status'] != 'deleted':
				var i = load('res://actors/ui/PreviewBox.tscn').instantiate()
				i.data = email
				i.get_node('SenderName').text = email['sender_name']
				i.get_node('Body').text = email['body']
				
				$InboxPanel/Panel/ScrollContainer/List.add_child(i)


func load_day_emails():
	# check for ignored emails --------------
	
	# check if hr has been ignored n times, run an action script after
	if ignored_hr_letters >= 6:
		ManagerGame.run_action_script("res://reso/action_scripts/hr_warning_unresponsive.tscn")
		
		$NextDay.hide()
	if ignored_work_letters >= 10:
		ManagerGame.run_action_script("res://reso/action_scripts/HRWarningIgnoringCoWorkers.tscn")
	if replied_personal_letters >= 10:
		pass
	if replied_phishing_letters >= 3:
		pass
	if ignored_important_letters >= 1:
		ManagerGame.run_action_script("res://reso/action_scripts/HRIgnoringImportantEmails.tscn")
	
	# ----------------------------------------
	
	var e = ManagerGame.emails_data['day_%s' % day]
	e.reverse()
	
	for email in e:
		emails.push_front(email)
	
	refresh_emails_display()
	
	on_email_viewed(null)


func game_over():
	var i = load('res://actors/ui/GameOverView.tscn').instantiate()
	ManagerGame.pop_to_ui.emit(i)


func on_pop_to_ui(instance):
	
	$Popup.add_child(instance)


func on_email_viewed(data):
	var new_emails = 0
	for e in emails:
		if e.has('is_viewed') == false:
			new_emails += 1
	
	$InboxPanel/HBoxContainer/Inbox.text = 'Inbox (%s)' % new_emails


func on_email_deleted(data):
	refresh_emails_display()
	
	var deleted = 0
	for e in emails:
		if e.has('status'):
			if e['status'] == 'deleted':
				deleted += 1
	
	$InboxPanel/HBoxContainer/Deleted.text = 'Deleted (%s)' % deleted


func _on_next_day_pressed() -> void:
	day += 1
	
	Sfx.play_sound('Click')
	
	ManagerGame.fade_in()
	await ManagerGame.transition_step_finished
	
	# check days
	if day > ManagerGame.emails_data.size():
		game_over()
		return
	
	#ManagerGame.fade_out()
	
	load_day_emails()
	
	ManagerGame.next_day_activated.emit()


func _on_inbox_pressed() -> void:
	Sfx.play_sound('Click')
	
	refresh_emails_display()


func _on_deleted_pressed() -> void:
	Sfx.play_sound('Click')
	
	for child in $InboxPanel/Panel/ScrollContainer/List.get_children():
		child.queue_free()
	
	for email in emails:
		if email.has('status'):
			if email['status'] == 'deleted':
				var i = load('res://actors/ui/PreviewBox.tscn').instantiate()
				i.data = email
				i.get_node('SenderName').text = email['sender_name']
				i.get_node('Body').text = email['body']
				
				$InboxPanel/Panel/ScrollContainer/List.add_child(i)
